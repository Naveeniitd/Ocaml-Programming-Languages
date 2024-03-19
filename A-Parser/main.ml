open Ast

let indent level = String.make (level * 2) ' '

let rec string_of_term level = function
  | Variable(var) -> indent level ^ "Variable: " ^ var
  | Constant(const) -> indent level ^ "Constant: " ^ const
  | Function(func, terms) ->
    indent level ^ "Function: " ^ func ^ "\n" ^
    String.concat "\n" (List.map (string_of_term (level + 1)) terms)

let string_of_atomic_formula level (Predicate(pred, terms)) =
  indent level ^ "Predicate: " ^ pred ^ "\n" ^
  String.concat "\n" (List.map (string_of_term (level + 1)) terms)

let rec string_of_clause level = function
  | Fact(f) -> indent level ^ "Fact:\n" ^ string_of_atomic_formula (level + 1) f
  | Rule(h, b) ->
    indent level ^ "Rule:\n" ^ string_of_atomic_formula (level + 1) h ^ "\n" ^
    indent (level + 1) ^ "Body:\n" ^
    String.concat "\n" (List.map (string_of_atomic_formula (level + 2)) b)

let string_of_program program =
  String.concat "\n\n" (List.map (string_of_clause 0) program)

let () =
  let lexbuf = Lexing.from_channel stdin in
  lexbuf.Lexing.lex_curr_p <- { lexbuf.Lexing.lex_curr_p with pos_fname = "stdin" };
  try
    let parsed_program = Parser.program Lexer.token lexbuf in
    print_endline (string_of_program parsed_program)
  with
  | Parsing.Parse_error -> 
    let pos = lexbuf.Lexing.lex_curr_p in
    Printf.eprintf "Parser error at line %d, position %d\n" pos.Lexing.pos_lnum (pos.Lexing.pos_cnum - pos.Lexing.pos_bol);
  | Failure msg -> prerr_endline ("Error: " ^ msg)
  | _ -> prerr_endline "Unknown error"
