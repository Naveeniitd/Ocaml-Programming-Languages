#!/bin/bash


echo "Generating lexer..."
ocamllex Lex.mll -o lex.ml

if [ $? -ne 0 ]; then
  echo "ocamllex failed to generate the lexer. Exiting."
  exit 1
fi

echo "Compiling source files..."
ocamlc -o a3 lex.ml main.ml

# Check if ocamlc succeeded
if [ $? -ne 0 ]; then
  echo "Compilation failed. Exiting."
  exit 1
fi

# Step 3: Run the program
echo "Running the program..."
./a3 input.txt

# Cleanup (Optional)
# Uncomment the following line if you want to remove the generated and compiled files after execution
# rm lex.ml my_program *.cmi *.cmo
