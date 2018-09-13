
        //------------------------------------------------------------------------
        //returns number of text sub-strings separated by one or more delimiters
        //------------------------------------------------------------------------
        Dcl-PR words Int(10) extproc(*CWIDEN:'words');
          inputStr       Varchar(32766) const options(*varsize);
          delimiters     Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        //returns word index to the key in the list:
        //where index starts with 1 as the first
        //it return 0 if not found
        //------------------------------------------------------------------------
        Dcl-PR wordIx Int(10) extproc(*CWIDEN:'wordIx');
          inputStr       Varchar(32766) const options(*varsize);
          key            Varchar(512) const options(*varsize);
          delimiters     Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        //returns word index to the key in the list ignoring upper/lower case
        //where index starts with 1 as the first
        //it return 0 if not found
        //------------------------------------------------------------------------
        Dcl-PR wordIxNoCase Int(10) extproc(*CWIDEN:'wordIxNoCase');
          inputStr       Varchar(32766) const options(*varsize);
          key            Varchar(512) const options(*varsize);
          delimiters     Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        //returns the n'th text sub-strings separated by one or more delimiters
        //where index starts with 1 as the first
        //------------------------------------------------------------------------
        Dcl-PR word Varchar(32768) extproc(*CWIDEN:'word');
          inputStr       Varchar(32766) const options(*varsize);
          index          Int(10)    value;
          delimiters     Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        //returns the n'th text sub-strings separated by one or more delimiters
        //where index starts with 1 as the rightmost ( the last occurnce)
        //------------------------------------------------------------------------
        Dcl-PR wordRight Varchar(32768) extproc(*CWIDEN:'wordRight');
          inputStr       Varchar(32766) const options(*varsize);
          index          Int(10)    value;
          delimiters     Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        //returns number of text sub-strings separated by one or more delimiters
        //conforms to a record in a CSV file
        //------------------------------------------------------------------------
        Dcl-PR csvWords Int(10) extproc(*CWIDEN:'csvWords');
          inputStr       Varchar(32766) const options(*varsize);
          delimiter      Char(1)    value;
          stringQuote    Char(1)    value;
        End-PR;


        //------------------------------------------------------------------------
        //returns the n'th text sub-strings separated by one or more delimiters
        //where index starts with 1 as the first
        //------------------------------------------------------------------------
        Dcl-PR csvWord Varchar(32768) extproc(*CWIDEN:'csvWord');
          inputStr       Varchar(32766) const options(*varsize);
          index          Int(10)    value;
          delimiter      Char(1)    value;
          stringQuote    Char(1)    value;
        End-PR;

        //------------------------------------------------------------------------
        //returns numeric value of a string
        //------------------------------------------------------------------------
        Dcl-PR nval Packed(30:15) extproc(*CWIDEN:'nval') opdesc;
          inputString    Pointer    value options(*string);
          DecimalPoint   Char(1)    value options(*nopass);
        End-PR;

        //------------------------------------------------------------------------
        //replace any occurences of a substring i source string
        //------------------------------------------------------------------------
        Dcl-PR strReplace Varchar(32768) extproc(*CWIDEN:'strReplace');
          base           Pointer    value options(*string);
          from           Pointer    value options(*string);
          to             Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        //returns the right number of bytes from the input string
        //------------------------------------------------------------------------
        Dcl-PR strRight Varchar(32768) extproc(*CWIDEN:'strRight');
          inputStr       Varchar(32766) const options(*varsize);
          length         Int(10)    value;
        End-PR;

        //------------------------------------------------------------------------
        //returns the left number of bytes from the input string
        //------------------------------------------------------------------------
        Dcl-PR strLeft Varchar(32768) extproc(*CWIDEN:'strLeft');
          inputStr       Varchar(32766) const options(*varsize);
          length         Int(10)    value;
        End-PR;

        //------------------------------------------------------------------------
        //returns the "length" number of bytes from the input 
        // string starting a "pposition"
        //------------------------------------------------------------------------
        Dcl-PR strMid Varchar(32768) extproc(*CWIDEN:'strMid');
          inputStr       Varchar(32768) const options(*varsize);
          startPos       Int(10)    value;
          length         Int(10)    value options(*nopass);
        End-PR;

        //------------------------------------------------------------------------
        Dcl-PR strUpper Varchar(32768) extproc(*CWIDEN:'strUpper');
          inputStr       Varchar(32768) const options(*varsize);
        End-PR;

        //------------------------------------------------------------------------
        Dcl-PR strLower Varchar(32768) extproc(*CWIDEN:'strLower');
          inputStr       Varchar(32768) const options(*varsize);
        End-PR;

        //------------------------------------------------------------------------
        Dcl-PR strQuot Varchar(32768) extproc(*CWIDEN:'strQuot');
          input          Pointer    value options(*string);
        End-PR;

        //------------------------------------------------------------------------
        Dcl-PR strError Varchar(256) extproc(*CWIDEN:'strError');
        End-PR;