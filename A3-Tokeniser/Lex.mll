{
  type token =
  | IF
  | THEN
  | ELSE
  | TRUE
  | FALSE
  | IDENT of string
  | PLUS
  | MINUS
  | MULT
  | DIV
  | EQUAL
  | EQ
  | NEQ
  | LT
  | GT
  | LE
  | GE
  | AND
  | OR
  | NOT
  | LET
  | PAIR
  | FST
  | SND
  | INT of int
  | STRING of string
  | LPAREN
  | RPAREN
  | COMMA
  | EOF


  exception Lexing_error of string
  let lexing_error msg lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  let err = Printf.sprintf "Error at line %d, position %d: %s"
              pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1) msg in
  raise (Lexing_error err)
}


let lower = ['a'-'z']
let upper = ['A'-'Z']
let digit = ['0'-'9']
let identifier_start = (lower | '_')
let identifier_continue = (lower | upper | digit | '\'' | '_')

let whitespace = [' ' '\t'  '\r' '\n']+
let identifier = identifier_start identifier_continue*
let keyword = "if" | "then" | "else" | "true" | "false" | "let" | "pair" | "fst" | "snd"
let arithmetic_op = '+' | '-' | '*' | '/'
let comparison_op = "<" | ">" | "==" | "!=" | "<=" | ">=" | "="
let boolean_op = "&&" | "||" | "!"
let integer = digit+
let string_lit = '"' [^'"']* '"'

rule token = parse
  | whitespace { token lexbuf }
  | keyword as kwd { match kwd with
      "let" -> LET
    | "pair" -> PAIR
    | "fst" -> FST
    | "snd" -> SND
    | "if" -> IF
    | "then" -> THEN
    | "else" -> ELSE
    | "true" -> TRUE
    | "false" -> FALSE
    | _ -> lexing_error "Unexpected keyword" lexbuf
    }
  | identifier as id { IDENT id }
  | arithmetic_op as op { match op with
      '+' -> PLUS
    | '-' -> MINUS
    | '*' -> MULT
    | '/' -> DIV
    | _ -> lexing_error "Unexpected operator" lexbuf
    }
  | comparison_op as op { match op with
      "<" -> LT
    | ">" -> GT
    | "==" -> EQ
    | "!=" -> NEQ
    | "<=" -> LE
    | ">=" -> GE
    | "="  -> EQUAL
    | _ -> lexing_error "Unexpected comparison operator" lexbuf
    }
  | boolean_op as op { match op with
      "&&" -> AND
    | "||" -> OR
    | "!" -> NOT
    | _ -> lexing_error "Unexpected boolean operator" lexbuf
    }
  | integer as num { INT (int_of_string num) }
  | string_lit as str { STRING (String.sub str 1 (String.length str - 2)) }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ',' { COMMA }
  | _ { lexing_error "Unknown token" lexbuf }

{

  let rec lex_main lexbuf =
    try Some (token lexbuf) with
    | Lexing_error msg -> Printf.eprintf "%s\n" msg; None
}

