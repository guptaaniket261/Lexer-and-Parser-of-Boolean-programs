(*empty user declaration part*)



%%

%eop EOF
%pos int


(*associativity rules and precedence order*)
%right IF THEN ELSE
%right IMPLIES
%left AND OR XOR EQUALS
%right NOT



(*structure name*)
%name Bool

(*terminal symbols*)
%term TERM | EOF | CONST of string | NOT | AND | OR | XOR | EQUALS | IMPLIES | IF | THEN | ELSE | LPAREN | RPAREN | ID of string

(*non-terminal symbols*)
%nonterm program of string option| statement of string | statementList of string | formula of string 

(*token to stop shifting*)
%noshift EOF


(*start symbol for the language*)
%start program
%verbose

%%
program: statementList (if (statementList="statementList: eps") then NONE else SOME (statementList ^ ", program: statementList"))

statementList: statement statementList (statement ^ ", " ^ statementList ^ ", statementList: statement statementList")
            |                          ("statementList: eps")

statement: formula TERM (formula ^ ", TERM ;, statement: formula TERM")

formula: IF formula THEN formula ELSE formula ("IF IF, " ^ formula1 ^ ", THEN THEN, " ^ formula2 ^ ", ELSE ELSE, " ^ formula3 ^ ", formula: IF formula THEN formula ELSE formula")
        | formula IMPLIES formula (formula1 ^ ", IMPLIES IMPLIES, " ^ formula2 ^ ", formula: formula IMPLIES formula")
        | formula AND formula (formula1 ^ ", AND AND, " ^ formula2 ^ ", formula: formula AND formula")
        | formula XOR formula (formula1 ^ ", XOR XOR, " ^ formula2 ^ ", formula: formula XOR formula")
        | formula OR formula (formula1 ^ ", OR OR, " ^ formula2 ^ ", formula: formula OR formula")
        | formula EQUALS formula (formula1 ^ ", EQUALS EQUALS, " ^ formula2 ^ ", formula: formula EQUALS formula")
        | NOT formula ("NOT NOT, " ^ formula ^ ", formula: NOT formula")
        | ID  ("ID " ^ ID ^ ", formula: ID")
        | CONST ("CONST " ^ CONST ^ ", formula: CONST")
        | LPAREN formula RPAREN ("LPAREN (, " ^ formula ^ ", RPAREN ), " ^ "formula: LPAREN formula RPAREN" ) 