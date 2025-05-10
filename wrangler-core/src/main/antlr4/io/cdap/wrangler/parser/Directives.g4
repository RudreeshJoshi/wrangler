/*
 * Copyright © 2017-2019 Cask Data, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

grammar Directives;

options {
  language = Java;
}

@lexer::header {
  /*
   * Copyright © 2017-2019 Cask Data, Inc.
   *
   * Licensed under the Apache License, Version 2.0 (the "License"); you may not
   * use this file except in compliance with the License. You may obtain a copy of
   * the License at
   *
   * http://www.apache.org/licenses/LICENSE-2.0
   *
   * Unless required by applicable law or agreed to in writing, software
   * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
   * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
   * License for the specific language governing permissions and limitations under
   * the License.
   */
}

/**
 * Parser Grammar for recognizing tokens and constructs of the directives language.
 */
recipe
 : statements EOF
 ;

statements
 :  ( Comment | macro | directive ';' | pragma ';' | ifStatement)*
 ;

directive
 : command
  (   codeblock
    | identifier
    | macro
    | text
    | number
    | bool
    | column
    | colList
    | numberList
    | boolList
    | stringList
    | numberRanges
    | properties
  )*?
  ;

ifStatement
  : ifStat elseIfStat* elseStat? '}'
  ;

ifStat
  : 'if' expression '{' statements
  ;

elseIfStat
  : '}' 'else' 'if' expression '{' statements
  ;

elseStat
  : '}' 'else' '{' statements
  ;

expression
  : '(' (~'(' | expression)* ')'
  ;

forStatement
 : 'for' '(' Identifier '=' expression ';' expression ';' expression ')' '{'  statements '}'
 ;

macro
 : Dollar OBrace (~OBrace | macro | Macro)*? CBrace
 ;

pragma
 : '#pragma' (pragmaLoadDirective | pragmaVersion)
 ;

pragmaLoadDirective
 : 'load-directives' identifierList
 ;

pragmaVersion
 : 'version' Number
 ;

codeblock
 : 'exp' Space* ':' condition
 ;

identifier
 : Identifier
 ;

properties
 : 'prop' ':' OBrace (propertyList)+  CBrace
 | 'prop' ':' OBrace OBrace (propertyList)+ CBrace { notifyErrorListeners("Too many start paranthesis"); }
 | 'prop' ':' OBrace (propertyList)+ CBrace CBrace { notifyErrorListeners("Too many start paranthesis"); }
 | 'prop' ':' (propertyList)+ CBrace { notifyErrorListeners("Missing opening brace"); }
 | 'prop' ':' OBrace (propertyList)+  { notifyErrorListeners("Missing closing brace"); }
 ;

propertyList
 : property (',' property)*
 ;

property
 : Identifier '=' ( text | number | bool )
 ;

numberRanges
 : numberRange ( ',' numberRange)*
 ;

numberRange
 : Number ':' Number '=' value
 ;

**// Updated 'value' rule to include BYTE_SIZE and TIME_DURATION tokens**
value
 : String
 | Number
 | Column
 | Bool
 | BYTE_SIZE      // New token for byte size e.g., "10MB"
 | TIME_DURATION  // New token for time duration e.g., "150ms"
 ;

ecommand
 : '!' Identifier
 ;

config
 : Identifier
 ;

column
 : Column
 ;

text
 : String
 ;

number
 : Number
 ;

bool
 : Bool
 ;

condition
 : OBrace (~CBrace | condition)* CBrace
 ;

command
 : Identifier
 ;

colList
 : Column (','  Column)+
 ;

numberList
 : Number (',' Number)+
 ;

boolList
 : Bool (',' Bool)+
 ;

stringList
 : String (',' String)+
 ;

identifierList
 : Identifier (',' Identifier)*
 ;


/*
 * Following are the Lexer Rules used for tokenizing the recipe.
 */
OBrace   : '{';
CBrace   : '}';
SColon   : ';';
Or       : '||';
And      : '&&';
Equals   : '==';
NEquals  : '!=';
GTEquals : '>=';
LTEquals : '<=';
Match    : '=~';
NotMatch : '!~';
QuestionColon : '?:';
StartsWith : '=^';
NotStartsWith : '!^';
EndsWith : '=

---

**Summary of Changes:**
- **Added two new lexer tokens:** `BYTE_SIZE` and `TIME_DURATION`.
- **Updated** the `value` parser rule to include these tokens.

**Note:** Be sure after editing the grammar file, to regenerate the lexer and parser using your build process (e.g., `mvn compile`) to incorporate these language changes into your Java classes.

Let me know if you'd like further help with the Java class implementations or usage examples!;
NotEndsWith : '!

---

**Summary of Changes:**
- **Added two new lexer tokens:** __INLINE_CODE_5__ and __INLINE_CODE_6__.
- **Updated** the __INLINE_CODE_7__ parser rule to include these tokens.

**Note:** Be sure after editing the grammar file, to regenerate the lexer and parser using your build process (e.g., __INLINE_CODE_8__) to incorporate these language changes into your Java classes.

Let me know if you'd like further help with the Java class implementations or usage examples!;
PlusEqual : '+=';
SubEqual : '-=';
MulEqual : '*=';
DivEqual : '/=';
PerEqual : '%=';
AndEqual : '&=';
OrEqual  : '|=';
XOREqual : '^=';
Pow      : '^';
External : '!';
GT       : '>';
LT       : '<';
Add      : '+';
Subtract : '-';
Multiply : '*';
Divide   : '/';
Modulus  : '%';
OBracket : '[';
CBracket : ']';
OParen   : '(';
CParen   : ')';
Assign   : '=';
Comma    : ',';
QMark    : '?';
Colon    : ':';
Dot      : '.';
At       : '@';
Pipe     : '|';
BackSlash: '\\';
Dollar   : '

---

**Summary of Changes:**
- **Added two new lexer tokens:** __INLINE_CODE_5__ and __INLINE_CODE_6__.
- **Updated** the __INLINE_CODE_7__ parser rule to include these tokens.

**Note:** Be sure after editing the grammar file, to regenerate the lexer and parser using your build process (e.g., __INLINE_CODE_8__) to incorporate these language changes into your Java classes.

Let me know if you'd like further help with the Java class implementations or usage examples!;
Tilde    : '~';

/*
 * New lexer rules for byte size and time duration units
 */
BYTE_SIZE
 : [0-9]+ ( 'KB' | 'MB' | 'GB' | 'kB' | 'mB' | 'gB' | 'k' | 'm' | 'g' ) // integer + unit
 ;

TIME_DURATION
 : [0-9]+ ( 'ms' | 's' | 'm' | 'h' | 'd' ) // integer + unit
 ;

/*
 * Others
 */
Bool
 : 'true'
 | 'false'
 ;

Number
 : Int ('.' Digit*)?
 ;

Identifier
 : [a-zA-Z_\-] [a-zA-Z_0-9\-]*
 ;

Macro
 : [a-zA-Z_] [a-zA-Z_0-9]*
 ;

Column
 : ':' [a-zA-Z_\-] [:a-zA-Z_0-9\-]*
 ;

String
 : '\'' ( EscapeSequence | ~('\'') )* '\''
 | '"'  ( EscapeSequence | ~('"') )* '"'
 ;

EscapeSequence
   :   '\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\')
   |   UnicodeEscape
   |   OctalEscape
   ;

fragment
OctalEscape
   :   '\\' ('0'..'3') ('0'..'7') ('0'..'7')
   |   '\\' ('0'..'7') ('0'..'7')
   |   '\\' ('0'..'7')
   ;

fragment
UnicodeEscape
   :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
   ;

fragment
   HexDigit : ('0'..'9'|'a'..'f'|'A'..'F') ;

/*
 * Comment and whitespace rules
 */
Comment
 : ('//' ~[\r\n]* | '/*' .*? '*/' | '--' ~[\r\n]* ) -> skip
 ;

Space
 : [ \t\r\n\u000C]+ -> skip
 ;

/* Skip trailing rules for int/digit tokens if necessary: */
fragment Int
 : '-'? [1-9] Digit* [L]*
 | '0'
 ;

fragment Digit
 : [0-9]
 ;
