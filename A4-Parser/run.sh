#!/bin/bash


echo "Compiling AST..."
ocamlc -c ast.ml
if [ $? -ne 0 ]; then
  echo "Failed to compile ast.ml. Exiting."
  exit 1
fi

echo "Generating and compiling parser..."
ocamlyacc parser.mly
if [ $? -ne 0 ]; then
  echo "Failed to generate parser from parser.mly. Exiting."
  exit 1
fi
ocamlc -c parser.mli
ocamlc -c parser.ml

echo "Generating and compiling lexer..."
ocamllex lexer.mll
if [ $? -ne 0 ]; then
  echo "Failed to generate lexer from lexer.mll. Exiting."
  exit 1
fi
ocamlc -c lexer.ml


echo "Compiling main module..."
ocamlc -c main.ml


echo "Linking into an executable..."
ocamlc -o my_parser ast.cmo lexer.cmo parser.cmo main.cmo
if [ $? -ne 0 ]; then
  echo "Failed to link the executable. Exiting."
  exit 1
fi


echo "Running the parser with input from input.txt..."
./my_parser < input.txt

