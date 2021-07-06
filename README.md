# Lexing and Parsing
This assignment was done as a part of PROGRAMMING LANGUAGES (COL226) course.
Lexer and parser for Boolean algebra using ML-Lex and ML-Yacc.

# Problem Specification
1. The input file consists of a single input program. Define a non-terminal **program** for the entire program. Each file should end with a token type **EOF**.
2. A program is a set of statements. A statement is a boolean formula followed by a termination character semicolon (“;”). Use non-terminal **statement** for a valid statement and token type **TERM** for semicolon.
3. Represent a formula by non-terminal formula. A formula may consists of: 
(a) Constants “TRUE” and “FALSE” representing bool 1 and 0 respectively. Use token type **CONST** for constants.
(b) Right-to-left associative prefix unary operator “NOT” of a formula, having form “NOT formula”. Use token type **NOT** for token “NOT”.
(c) Left-to-right associative infix binary operators over two formulas, having form “formula1 binop formula2”, where “binop” can be “AND”, “OR”, “XOR” and “EQUALS”. Represent these using token types **AND**, **OR**, **XOR** and **EQUALS** respectively.
(d) Right-to-left associative implication operator of the form “formula1 IMPLIES formula2”. Use token type **IMPLIES** for token “IMPLIES”.
(e) Right-to-left associative if-then-else operator of the form “IF formula1 THEN formula2 ELSE formula3”. Use token types **IF, THEN** and **ELSE** for “IF”, “THEN” and “ELSE”.
(f) Parenthesis to define order of evaluation over different operations “(formula)”. Use token types **LPAREN** and **RPAREN** for left and right parenthesis respectively.
(g) For formulas and sub-formulas without parenthesis, the order of evaluation is decided according to associativity rules.
(h) Any other string containing only lower and upper case English alphabets is a variable. Use token type **ID** for variable identifiers.
(i) All the operations mentioned in any point above have the same precedence, and the precedence is decreasing from point 3b to point 3e. For example, NOT operation has higher precedence than AND, OR, XOR and EQUALS operations.

# To execute the code your input file:-
1. First open sml interactive window on your terminal.
2. Give command - use "loader.sml" . This will load all the required files in the correct order required.
3. Give command - parseFile(inputFile_name) . Your input file should be in same directory which contains the other files of this assignment.

This will give the required output on the interactive window.
