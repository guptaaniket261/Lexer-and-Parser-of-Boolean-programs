structure Tokens = Tokens

type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult= (svalue,pos) token

val pos = ref 1        (*line no*)
val eof = fn () => Tokens.EOF(!pos,!pos)         (*eof function called at end of file*)
val column = ref 1                               (*column no in the present line*)

(*error function called in case of error*)
val error = fn (line,col,tok) => TextIO.output(TextIO.stdErr,"\nUnknown Token:" ^ (Int.toString(line)) ^ ":" ^ (Int.toString(col)) ^ ":" ^ tok ^ "\n" )

(*counts no of tokens found*)
val tok_no = ref 0



%%
%header (functor BoolLexFun(structure Tokens: Bool_TOKENS));
alphabet =[A-Za-z];
space = [\ \t];

%%


\n => (pos:= (!pos)+1 ; column:= 1; lex() );

{space}+ => (column:= (!column)+size(yytext) ; lex());

";" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("TERM \""^yytext^"\""); tok_no:=(!tok_no)+1 ; Tokens.TERM(!pos,!(column)-size(yytext)));

"TRUE" | "FALSE" => (column:= (!column)+size(yytext) ;(if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("CONST \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.CONST(yytext,!pos,!(column)-size(yytext)));

"NOT" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("NOT \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.NOT(!pos,!(column)-size(yytext)));

"AND" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("AND \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.AND(!pos,!(column)-size(yytext)));

"OR" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("OR \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.OR(!pos,!(column)-size(yytext)));

"XOR" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("XOR \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.XOR(!pos,!(column)-size(yytext)));

"EQUALS" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("EQUALS \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.EQUALS(!pos,!(column)-size(yytext)));

"IMPLIES" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("IMPLIES \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.IMPLIES(!pos,!(column)-size(yytext)));

"IF" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("IF \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.IF(!pos,!(column)-size(yytext)));

"THEN" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("THEN \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.THEN(!pos,!(column)-size(yytext)));

"ELSE" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("ELSE \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.ELSE(!pos,!(column)-size(yytext)));

"(" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("LPAREN \""^yytext^"\""); tok_no:=(!tok_no)+1 ; Tokens.LPAREN(!pos,!(column)-size(yytext)));

")" => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("RPAREN \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.RPAREN(!pos,!(column)-size(yytext)));

{alphabet}+ => (column:= (!column)+size(yytext) ; (if (not(!(tok_no)=0)) then (print(", ")) else ()) ;
        print("ID \""^yytext^"\""); tok_no:=(!tok_no)+1 ;  Tokens.ID(yytext,!pos,!(column)-size(yytext)));

. => (error (!pos,!column,yytext); column:= (!column)+size(yytext) ; lex());

