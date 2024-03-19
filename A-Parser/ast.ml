type variable = string
type constant = string
type predicate = string
type function_symbol = string

type term =
  | Variable of variable
  | Constant of constant
  | Function of function_symbol * term list

type atomic_formula = Predicate of predicate * term list

type clause =
  | Fact of atomic_formula
  | Rule of atomic_formula * atomic_formula list

type program = clause list

type goal = atomic_formula list