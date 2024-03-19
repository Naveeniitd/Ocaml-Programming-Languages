%{
open Ast
%}


/* Define the tokens used in your grammar */
%token <string> VARIABLE CONSTANT PREDICATE
%token LPAREN RPAREN COMMA DOT IMPLIES
%token EOF
%start program
%type <Ast.program> program

%%

program:
  | clauses { $1 }

clauses:
  | clause clauses { $1 :: $2 }
  | clause         { [$1] }

clause:
  | atomic_formula DOT { Fact($1) }
  | atomic_formula IMPLIES atomic_formulas DOT { Rule($1, $3) }


atomic_formulas:
  | atomic_formula COMMA atomic_formulas { $1 :: $3 }
  | atomic_formula                       { [$1] }

atomic_formula:
  | predicate LPAREN terms RPAREN { Predicate($1, $3) }

terms:
  | term COMMA terms { $1 :: $3 }
  | term             { [$1] }

term:
  | CONSTANT        { Constant($1) }
  | VARIABLE        { Variable($1) }
  | function_symbol LPAREN terms RPAREN { Function($1, $3) }

predicate: CONSTANT { $1 }
function_symbol: CONSTANT { $1 }
