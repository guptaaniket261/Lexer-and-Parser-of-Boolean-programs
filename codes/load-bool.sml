structure BoolLrVals = BoolLrValsFun(structure Token = LrParser.Token)
structure BoolLex = 
  BoolLexFun(structure Tokens = BoolLrVals.Tokens)
structure BoolParser=
  Join(structure ParserData = BoolLrVals.ParserData
       structure Lex=BoolLex
       structure LrParser=LrParser)



(*It is the main function that calls the parsing method over the stream of tokens*)
fun invoke lexstream =
    let fun print_error (s,i:int,j:int) =
            TextIO.output(TextIO.stdErr,
                          "\nSyntax Error:" ^ (Int.toString i) ^ ":" ^ Int.toString(j) ^":"^ s ^"\n")
     in BoolParser.parse(0,lexstream,print_error,())
    end





(*reads input from a file and returns a stream of tokens*)
fun fileToLexer(filename) = 
    let val t = BoolLex.UserDeclarations.column := 1
        val tt = BoolLex.UserDeclarations.pos := 1
        val ttt = BoolLex.UserDeclarations.tok_no := 0
        val input_str=TextIO.openIn(filename) 
        val lexer = BoolParser.makeLexer(fn n => case TextIO.inputLine(input_str) of
                                                SOME line => line
                                                | NONE => "")
    in 
        lexer
    end




(*parser function that calls invoke function with the token stream as param*)
fun parser(lexer) = 
    let val dummyEOF = BoolLrVals.Tokens.EOF(0,0)
        val xyz = print("[");
        val (result, lexer) = invoke lexer
        val (nextToken, lexer) = BoolParser.Stream.get lexer
    in 
        print("]\n");
        if BoolParser.sameToken(nextToken, dummyEOF) then (print("[");
                                                            case result of 
                                                                SOME text => print(text)
                                                                |NONE => print(""); 
                                                            print("]\n"))
        else (TextIO.output(TextIO.stdOut, "\n Warning: Some input still remaining \n");
            print("[");
            case result of 
                SOME text => print(text)
                |NONE => print(""); 
            print("]\n"))                                                
    end


val parseFile = parser o fileToLexer


(*I have used the invoke function and some part of parser function directly from the load-calc.sml file provided by Prof. Subodh Sharma and Prof S. Arun Kumar
I don't claim these as my own work.*)
