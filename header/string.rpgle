
      * ------------------------------------------------------------------------
      * returns number of text sub-strings separated by one or more delimiters
      * ------------------------------------------------------------------------
     D words...
     D                 pr            10i 0
     d                                     extproc(*CWIDEN:'words')
     D   inputStr                 32766    const options(*varsize) varying
     D   delimiters                    *   value options(*string)

      * ------------------------------------------------------------------------
      * returns word index to the key in the list:
      * where index starts with 1 as the first
      * it return 0 if not found
      * ------------------------------------------------------------------------
     D wordIx...
     D                 pr            10i 0
     D                                     extproc(*CWIDEN:'wordIx')
     D   inputStr                 32766    const options(*varsize) varying
     D   key                        512    const options(*varsize) varying
     D   delimiters                    *   value options(*string)

      * ------------------------------------------------------------------------
      * returns word index to the key in the list ignoring upper/lower case
      * where index starts with 1 as the first
      * it return 0 if not found
      * ------------------------------------------------------------------------
     D wordIxNoCase...
     D                 pr            10i 0
     D                                     extproc(*CWIDEN:'wordIxNoCase')
     D   inputStr                 32766    const options(*varsize) varying
     D   key                        512    const options(*varsize) varying
     D   delimiters                    *   value options(*string)

      * ------------------------------------------------------------------------
      * returns the n'th text sub-strings separated by one or more delimiters
      * where index starts with 1 as the first
      * ------------------------------------------------------------------------
     D word...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'word')
     D   inputStr                 32766    const options(*varsize) varying
     D   index                       10i 0 value
     D   delimiters                    *   value options(*string)

      * ------------------------------------------------------------------------
      * returns the n'th text sub-strings separated by one or more delimiters
      * where index starts with 1 as the rightmost ( the last occurnce)
      * ------------------------------------------------------------------------
     D wordRight...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'wordRight')
     D   inputStr                 32766    const options(*varsize) varying
     D   index                       10i 0 value
     D   delimiters                    *   value options(*string)

      * ------------------------------------------------------------------------
      * returns number of text sub-strings separated by one or more delimiters
      * conforms to a record in a CSV file
      * ------------------------------------------------------------------------
     D csvWords...
     D                 pr            10i 0
     d                                     extproc(*CWIDEN:'csvWords')
     D   inputStr                 32766    const options(*varsize) varying
     D   delimiter                    1    value
     D   stringQuote                  1    value


      * ------------------------------------------------------------------------
      * returns the n'th text sub-strings separated by one or more delimiters
      * where index starts with 1 as the first
      * ------------------------------------------------------------------------
     D csvWord...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'csvWord')
     D   inputStr                 32766    const options(*varsize) varying
     D   index                       10i 0 value
     D   delimiter                    1    value
     D   stringQuote                  1    value

      * ------------------------------------------------------------------------
      * returns numeric value of a string
      * ------------------------------------------------------------------------
     D nval...
     d                 pr            30p15 extproc(*CWIDEN:'nval') opdesc
     D  inputString                    *   value options(*string)
     d  DecimalPoint                  1    value options(*nopass)

      * ------------------------------------------------------------------------
      * replace any occurences of a substring i source string
      * ------------------------------------------------------------------------
     d strReplace...
     d                 pr         32768    varying
     d                                     extproc(*CWIDEN:'strReplace')
     d  base                           *   value options(*string)
     d  from                           *   value options(*string)
     d  to                             *   value options(*string)

      * ------------------------------------------------------------------------
      * returns the left number of bytes from the input string
      * ------------------------------------------------------------------------
     D strLeft...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'strLeft')
     D   inputStr                 32766    const options(*varsize) varying
     D   length                      10i 0 value

      * ------------------------------------------------------------------------
      * returns the right number of bytes from the input string
      * ------------------------------------------------------------------------
     D strRight...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'strRight')
     D   inputStr                 32766    const options(*varsize) varying
     D   length                      10i 0 value

      * ------------------------------------------------------------------------
      * returns the "length" number of bytes from the input string starting a "position"
      * ------------------------------------------------------------------------
     D strMid...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'strMid')
     D   inputStr                 32768    const options(*varsize) varying
     D   startPos                    10i 0 value
     D   length                      10i 0 value options(*nopass)

      * ------------------------------------------------------------------------
      * returns the "length" number of bytes from the input string starting a "position"
      * ------------------------------------------------------------------------
     D strMid...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'strMid')
     D   inputStr                 32768    const options(*varsize) varying
     D   startPos                    10i 0 value
     D   length                      10i 0 value options(*nopass)

      * ------------------------------------------------------------------------
     D strUpper...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'strUpper')
     D   inputStr                 32768    const options(*varsize) varying

      * ------------------------------------------------------------------------
     D strLower...
     D                 pr         32768    varying
     D                                     extproc(*CWIDEN:'strLower')
     D   inputStr                 32768    const options(*varsize) varying

      * ------------------------------------------------------------------------
     d strQuot...
     d                 pr         32768    varying
     d                                     extproc(*CWIDEN:'strQuot')
     d  input                          *   value options(*string)

      * ------------------------------------------------------------------------
     D strError...
     D                 pr           256    varying
     D                                     extproc(*CWIDEN:'strError')