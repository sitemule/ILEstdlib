/* SYSIFCOPT(*IFSIO) TERASPACE(*YES *NOTSIFC) STGMDL(*SNGLVL)    */
/* ------------------------------------------------------------- */

#include <errno.h>
#include <string.h>
#include <ctype.h>
#include "ostypes.h"
#include "varchar.h"
#include "parms.h"

/* ------------------------------------------------------------- */

LONG words (PVARCHAR inputStr, PUCHAR  delimiters)
{
   LONG res =1;
   LONG i ;
   PUCHAR p;

   if (inputStr->Length == 0) return 0;

   for (i=0; i<inputStr->Length; i++) {
      p = strchr(delimiters , inputStr->String[i]);
      if (p) res++;
   }
   return res;
}

/* -------------------------------------------------------------
   Returns the index to the word: 1=First,2= Second  .. 0=Not found
   ------------------------------------------------------------- */
LONG wordIx (PVARCHAR inputStr, PVARCHAR key , PUCHAR  delimiters)
{
   LONG   ix =1;
   LONG   restlen = inputStr->Length;
   PUCHAR begin   = inputStr->String;
   PUCHAR end, nextbegin;
   BOOL   done = FALSE;
   UCHAR  delimiter  = delimiters[0]; // Todo - Support for the complete list

   do {

      restlen = inputStr->Length - (begin - inputStr->String);
      end = memchr(begin , delimiter , restlen);
      if (end == NULL) {
         end =  inputStr->String  + inputStr->Length;
         nextbegin = NULL;
      } else {
         nextbegin = end + 1;
      }
      // Quick trim;
      for(;*begin   == ' ' && begin < end ; begin++ );
      for(;*(end-1) == ' ' && begin < end ; end--   );
      // Does it match
      if (memcmp(begin , key->String, key->Length) == 0
      &&  key->Length == (end - begin)) {
         return ix;
      }
      ix ++;
      begin = nextbegin;
   } while (begin);
   return 0;  // Not found
}
/* -------------------------------------------------------------
   Returns the index to the word: 1=First,2= Second  .. 0=Not found
   ignoring case
   ------------------------------------------------------------- */
LONG wordIxNoCase (PVARCHAR inputStr, PVARCHAR key , PUCHAR  delimiters)
{
   LONG   ix =1;
   LONG   restlen = inputStr->Length;
   PUCHAR begin   = inputStr->String;
   PUCHAR end, nextbegin;
   BOOL   done = FALSE;
   UCHAR  delimiter  = delimiters[0]; // Todo - Support for the complete list

   do {
      restlen = inputStr->Length - (begin - inputStr->String);
      end = memchr(begin , delimiter , restlen);
      if (end == NULL) {
         end =  inputStr->String  + inputStr->Length;
         nextbegin = NULL;
      } else {
         nextbegin = end + 1;
      }
      // Quick trim;
      for(;*begin   == ' ' && begin < end ; begin++ );
      for(;*(end-1) == ' ' && begin < end ; end--   );
      // Does it match
      if (memicmp(begin , key->String, key->Length) == 0
      &&  key->Length == (end - begin)) {
         return ix;
      }
      ix ++;
      begin = nextbegin;
   } while (begin);
   return 0;  // Not found
}
/* ------------------------------------------------------------- */
VARCHAR word (PVARCHAR inputStr, LONG ix , PUCHAR delimiters)
{
   VARCHAR res;
   LONG cx  =1;
   PUCHAR p;
   LONG i;

   res.Length =0;
   if (inputStr->Length == 0) return res; // Not found

   // Find the next occurens
   for (i=0; i<inputStr->Length && cx <ix; i++) {
      p = strchr(delimiters , inputStr->String[i]);
      if (p) cx ++;
   }
   if (cx != ix) return res; // Not found

   // Find the first occurens
   for (;i<inputStr->Length; i++) {
      p = strchr(delimiters , inputStr->String[i]);
      if (p) break;
      res.String[res.Length++] = inputStr->String[i];
   }
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR wordRight (PVARCHAR inputStr, LONG ix , PUCHAR delimiters)
{
   VARCHAR res;
   LONG cx  =1;
   PUCHAR p;
   PUCHAR begin =  inputStr->String;
   PUCHAR end   =  begin + inputStr->Length -1;
   PUCHAR cur   =  end;

   res.Length =0;
   if (inputStr->Length == 0) return res; // Not found

   // Find the next occurens - step left to right
   for (; cur >=begin  && cx <ix; cur--) {
      p = strchr(delimiters , *cur );
      if (p)  {
         end = cur -1;
         cx ++;
      }
   }
   // Not found
   if (cx != ix) return res;

   // Find the beginig of ocurrens
   for (; cur >=begin; cur--) {
      p = strchr(delimiters , *cur  );
      if (p) {
        begin  = cur + 1;
        break;
      }
   }
   res.Length  = end - begin + 1;
   memcpy (res.String, begin , res.Length);
   return res;
}
/* ------------------------------------------------------------- */
LONG csvWords (PVARCHAR inputStr, UCHAR  delimiter, UCHAR stringQuote)
{
   LONG cx  =1;
   PUCHAR p;
   PUCHAR end = inputStr->String + inputStr->Length;
   SHORT mode =0;

   if (inputStr->Length == 0) return 0;

   for (p = inputStr->String; p <= end; p++) {
     if (mode == 0) {
       if (*p == stringQuote) {
         mode = 1; // In String
       } else if (*p == delimiter) {
         cx ++;
       } else if (p == end) {
         return cx;
       }
     } else { // Instring
       if (p[0] == stringQuote) {
         if (p[1] == stringQuote) {
            p++;
         } else {
            mode = 0;
         }
       }
     }
   }

   return -1;  // Invalid csv stream
}
/* ------------------------------------------------------------- */
VARCHAR csvWord (PVARCHAR inputStr, LONG ix , UCHAR delimiter, UCHAR stringQuote)
{
   VARCHAR res;
   LONG cx  =0;
   PUCHAR p;
   PUCHAR end = inputStr->String + inputStr->Length;
   LONG i;
   SHORT mode =0;
   PUCHAR out = res.String;

   res.Length =0;
   if (inputStr->Length == 0) return res; // Not found

   for (p = inputStr->String; p <= end; p++) {
     if (mode == 0) {
       if (*p == stringQuote) {
         mode = 1; // In String
       } else if (*p == delimiter || p == end) {
         cx ++;
         if (cx == ix) {
            res.Length = out - res.String;
            return res;
         }
         out = res.String;
       } else {
         *(out++) = *p;
       }
     } else { // Instring
       if (p[0] == stringQuote) {
         if (p[1] == stringQuote) {
            *(out++) = stringQuote;
            p++;
         } else {
            mode = 0;
         }
       } else {
         *(out++) = *p;
       }
     }
   }
   return res; // Not found
}
/* ------------------------------------------------------------- */
FIXEDDEC nval (PUCHAR in, UCHAR decPoint)
{
   PNPMPARMLISTADDRP pParms = _NPMPARMLISTADDR();
   FIXEDDEC        Res   = 0D;
   decimal(17,16)  Temp  = 0D;
   decimal(17)     Decs  = 1D;
   BOOL  DecFound = FALSE;
   UCHAR c = '0';
   int   FirstDigit = -1;
   int   LastDigit = -1;
   int   i;
   int   Dec=0;
   int   Prec=0;
   int   l = strlen (in);
   UCHAR DecPoint = (pParms->OpDescList->NbrOfParms >= 2) ? decPoint:'.';

   for (i=0; i < l ; i++) {
      c = in[i];
      if (c >= '0' && c <= '9' ) {
         if (FirstDigit == -1) FirstDigit = i;
         LastDigit = i;
         if (DecFound) {
           if (++Prec <= 15) {
              Decs  *= 10D;
              Temp = (c - '0');
              Temp /= Decs;
              Res += Temp;
           }
         } else {
           if (Dec < 15) {
             Res = Res * 10D + (c - '0');
             if (Res > 0D) Dec++;
           }
         }
      } else if (c == DecPoint) {
         DecFound = TRUE;
      }
   }
   if ((FirstDigit > 0 && in[FirstDigit-1] == '-')
   ||  (LastDigit  > 0 && in[LastDigit+1]  == '-' && (LastDigit + 1) < l )) {
      Res = - Res;
   }
   return (Res );
}
/* ------------------------------------------------------------- */
VARCHAR strReplace (PUCHAR base, PUCHAR from , PUCHAR to)
{
   VARCHAR res;
   PUCHAR in , out = res.String, end;
   int lFrom = strlen(from), lTo = strlen(to), len = strlen(base);

   in = base;
   end = in + len;

   while (in<end) {
     if (*in == *from
     &&  memcmp (in , from  , lFrom) ==0) {
       memcpy(out , to , lTo);
       out += lTo;
       in += lFrom;
     } else {
       *(out++) = *(in++);
     }
   }
   res.Length = (out - res.String);
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR strRight  (PVARCHAR inputStr, LONG len)
{
   VARCHAR res;
   LONG pos;

   if ( len <= 0 ) {
      res.Length = 0;
      return res;
   }

   pos =  inputStr->Length - len;
   if (pos < 0) {
      pos = 0;
      len = inputStr->Length;
   }

   memcpy (res.String , inputStr->String + pos , len);
   res.Length = len;
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR strLeft   (PVARCHAR inputStr, LONG len)
{
   VARCHAR res;
   LONG pos;

   if ( len <= 0 ) {
      res.Length = 0;
      return res;
   }

   if ( len > inputStr->Length)  {
      len = inputStr->Length;
   }

   memcpy (res.String , inputStr->String,  len);
   res.Length = len;
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR strMid  (PVARCHAR inputStr, LONG pos, LONG lenP)
{
   PNPMPARMLISTADDRP pParms = _NPMPARMLISTADDR();
   LONG len  = (pParms->OpDescList->NbrOfParms >= 3) ? lenP: 999999;
   VARCHAR res;
   LONG remains;

   if ( pos > inputStr->Length)  {
      res.Length = 0;
      return res;
   }
   pos --; // Convert to offset
   if ( pos < 0) pos = 0;

   remains = inputStr->Length - pos;
   if (remains < len) len = remains;

   memcpy (res.String , inputStr->String + pos,  len);
   res.Length = len;
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR strUpper  (PVARCHAR inputStr)
{
   VARCHAR res;

   PUCHAR p1 = inputStr->String;
   PUCHAR p2 = res.String;
   int len;

   res.Length = len = inputStr->Length;
   while (len --) {
     *(p2++) = toupper(*(p1++));
   }
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR strLower  (PVARCHAR inputStr)
{
   VARCHAR res;

   PUCHAR p1 = inputStr->String;
   PUCHAR p2 = res.String;
   int len;

   res.Length = len = inputStr->Length;
   while (len --) {
     *(p2++) = tolower(*(p1++));
   }
   return res;
}
/* ------------------------------------------------------------- */
VARCHAR strQuot   (PUCHAR base)
{
   VARCHAR res;
   VARCHAR temp;

   res.Length = 0;

   // double quote the complete string
   temp  = strReplace (base, "'" , "''");

   // now place a quote in the beining and the end
   vccatc    (&res , '\'');
   vccatvc   (&res , &temp);
   vccatc    (&res , '\'');

   return res;
}
/* ------------------------------------------------------------- */
VARCHAR256 strError  (void)
{
   VARCHAR256 res;
   strcpy(res.String , strerror(errno));
   res.Length = strlen(res.String);
   return res;
}
/* ------------------------------------------------------------- */