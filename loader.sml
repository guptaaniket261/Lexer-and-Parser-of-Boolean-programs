CM.make("$/basis.cm");
CM.make("$/ml-yacc-lib.cm");

use "bool.yacc.sig";
use "bool.yacc.sml";
use "bool.lex.sml";
use "load-bool.sml";

Control.Print.stringDepth := 10000;


(*loader file to load all the required files in correct order*)