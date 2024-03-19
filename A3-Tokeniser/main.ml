
open Lex


let string_of_token = function
  | IDENT s -> Printf.sprintf "IDENT(%s)" s
  | IF -> "IF"
  | THEN -> "THEN"
  | ELSE -> "ELSE"
  | TRUE -> "TRUE"
  | FALSE -> "FALSE"
  | PLUS -> "PLUS"
  | MINUS -> "MINUS"
  | MULT -> "MULT"
  | DIV -> "DIV"
  | EQUAL -> "EQUAL"
  | EQ -> "EQ"
  | NEQ -> "NEQ"
  | LT -> "LT"
  | GT -> "GT"
  | LE -> "LE"
  | GE -> "GE"
  | AND -> "AND"
  | OR -> "OR"
  | NOT -> "NOT"
  | INT n -> Printf.sprintf "INT(%d)" n
  | STRING s -> Printf.sprintf "STRING(%s)" s
  | LPAREN -> "LPAREN"
  | RPAREN -> "RPAREN"
  | COMMA -> "COMMA"
  | LET -> "LET"  
  | PAIR -> "PAIR" 
  | FST -> "FST" 
  | SND -> "SND"
  | EOF -> "EOF"



let rec print_tokens lexbuf =
  match Lex.token lexbuf with  
  | Lex.EOF -> ()
  | token ->
    print_endline (string_of_token token);
    print_tokens lexbuf

let () =
  let filename = Sys.argv.(1) in
  let in_channel = open_in filename in
  let lexbuf = Lexing.from_channel in_channel in
  try
    print_tokens lexbuf;
    close_in in_channel
  with
  | e ->
    close_in_noerr in_channel;  
    raise e