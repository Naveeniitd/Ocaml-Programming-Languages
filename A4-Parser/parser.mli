type token =
  | VARIABLE of (string)
  | CONSTANT of (string)
  | PREDICATE of (string)
  | LPAREN
  | RPAREN
  | COMMA
  | DOT
  | IMPLIES
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
