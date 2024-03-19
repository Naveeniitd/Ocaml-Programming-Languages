{
    open Parser
}

let uppercase = ['A'-'Z']
let lowercase = ['a'-'z']
let digit = ['0'-'9']
let identifier_tail = ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
| [' ' '\t' '\n']  { token lexbuf }  (* Whitespace *)
| uppercase identifier_tail as var { VARIABLE(var) }  (* Variables *)
| lowercase identifier_tail as const { CONSTANT(const) }  (* Constants *)
| ":-"              { IMPLIES }
| "."               { DOT }
| "("               { LPAREN }
| ")"               { RPAREN }
| ","               { COMMA }
| eof               { EOF }
| _ as char         { raise (Failure (Printf.sprintf "Unexpected character: '%c'" char)) }
