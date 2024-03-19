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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
open Ast
# 17 "parser.ml"
let yytransl_const = [|
  260 (* LPAREN *);
  261 (* RPAREN *);
  262 (* COMMA *);
  263 (* DOT *);
  264 (* IMPLIES *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* VARIABLE *);
  258 (* CONSTANT *);
  259 (* PREDICATE *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\005\000\005\000\004\000\
\007\000\007\000\008\000\008\000\008\000\006\000\009\000\000\000"

let yylen = "\002\000\
\001\000\002\000\001\000\002\000\004\000\003\000\001\000\004\000\
\003\000\001\000\001\000\001\000\004\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\014\000\016\000\001\000\000\000\000\000\000\000\
\002\000\004\000\000\000\000\000\000\000\000\000\012\000\000\000\
\000\000\000\000\000\000\000\000\005\000\008\000\000\000\000\000\
\006\000\009\000\000\000\013\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\007\000\014\000\008\000\017\000\018\000\
\019\000"

let yysindex = "\003\000\
\010\255\000\000\000\000\000\000\000\000\010\255\254\254\009\255\
\000\000\000\000\010\255\006\255\008\255\011\255\000\000\000\000\
\012\255\013\255\016\255\010\255\000\000\000\000\006\255\006\255\
\000\000\000\000\017\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\015\000\000\000\000\000\
\000\000\000\000\000\000\000\000\014\255\000\000\000\000\253\254\
\000\000\018\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\010\000\000\000\245\255\004\000\000\000\243\255\000\000\
\000\000"

let yytablesize = 24
let yytable = "\013\000\
\015\000\011\000\011\000\001\000\010\000\011\000\015\000\016\000\
\013\000\026\000\027\000\003\000\012\000\020\000\003\000\009\000\
\022\000\021\000\023\000\024\000\007\000\028\000\010\000\025\000"

let yycheck = "\011\000\
\004\001\005\001\006\001\001\000\007\001\008\001\001\001\002\001\
\020\000\023\000\024\000\002\001\004\001\006\001\000\000\006\000\
\005\001\007\001\006\001\004\001\007\001\005\001\005\001\020\000"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  COMMA\000\
  DOT\000\
  IMPLIES\000\
  EOF\000\
  "

let yynames_block = "\
  VARIABLE\000\
  CONSTANT\000\
  PREDICATE\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 16 "parser.mly"
            ( _1 )
# 100 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'clauses) in
    Obj.repr(
# 19 "parser.mly"
                   ( _1 :: _2 )
# 108 "parser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'clause) in
    Obj.repr(
# 20 "parser.mly"
                   ( [_1] )
# 115 "parser.ml"
               : 'clauses))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'atomic_formula) in
    Obj.repr(
# 23 "parser.mly"
                       ( Fact(_1) )
# 122 "parser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'atomic_formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'atomic_formulas) in
    Obj.repr(
# 24 "parser.mly"
                                               ( Rule(_1, _3) )
# 130 "parser.ml"
               : 'clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'atomic_formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_formulas) in
    Obj.repr(
# 28 "parser.mly"
                                         ( _1 :: _3 )
# 138 "parser.ml"
               : 'atomic_formulas))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_formula) in
    Obj.repr(
# 29 "parser.mly"
                                         ( [_1] )
# 145 "parser.ml"
               : 'atomic_formulas))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'predicate) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'terms) in
    Obj.repr(
# 32 "parser.mly"
                                  ( Predicate(_1, _3) )
# 153 "parser.ml"
               : 'atomic_formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'terms) in
    Obj.repr(
# 35 "parser.mly"
                     ( _1 :: _3 )
# 161 "parser.ml"
               : 'terms))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 36 "parser.mly"
                     ( [_1] )
# 168 "parser.ml"
               : 'terms))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 39 "parser.mly"
                    ( Constant(_1) )
# 175 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 40 "parser.mly"
                    ( Variable(_1) )
# 182 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'function_symbol) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'terms) in
    Obj.repr(
# 41 "parser.mly"
                                        ( Function(_1, _3) )
# 190 "parser.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 43 "parser.mly"
                    ( _1 )
# 197 "parser.ml"
               : 'predicate))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 44 "parser.mly"
                          ( _1 )
# 204 "parser.ml"
               : 'function_symbol))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
