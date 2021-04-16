defmodule CodeGeneratorTest2 do
  use ExUnit.Case
  # doctest Code Generator test
  # Solo hay 3 pruebas que serian los
  # casos validos de programas segun Nora
  ######################################################################################
  IO.puts("Pruebas del generador de codigo 2a parte")

  test "1.- Bitwise 0 " do
    assert CodeGenerator.generate_code(%AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :constant,
                   left_node: nil,
                   right_node: nil,
                   value: 2
                 },
                 right_node: nil,
                 value: nil
               },
               right_node: nil,
               value: :main
             },
             right_node: nil,
             value: nil
           }) == "\n    .section    __TEXT,__text,regular,pure_instructions\n    .p2align    4, 0x90\n\n    .globl  _main     ## --Begin fuction main\n_main:                ## @main\n\n    movl $2, %eax\n    ret\n"
  end

  test "2.- Nested Ops " do
    assert CodeGenerator.generate_code(%AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :constant,
                   left_node: nil,
                   right_node: nil,
                   value: 100
                 },
                 right_node: nil,
                 value: nil
               },
               right_node: nil,
               value: :main
             },
             right_node: nil,
             value: nil
           }) == "\n    .section    __TEXT,__text,regular,pure_instructions\n    .p2align    4, 0x90\n\n    .globl  _main     ## --Begin fuction main\n_main:                ## @main\n\n    movl $100, %eax\n    ret\n"
  end

  test "3.- Negative " do
    assert CodeGenerator.generate_code(%AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :constant,
                   left_node: nil,
                   right_node: nil,
                   value: 0
                 },
                 right_node: nil,
                 value: nil
               },
               right_node: nil,
               value: :main
             },
             right_node: nil,
             value: nil
           }) == "\n    .section    __TEXT,__text,regular,pure_instructions\n    .p2align    4, 0x90\n\n    .globl  _main     ## --Begin fuction main\n_main:                ## @main\n\n    movl $0, %eax\n    ret\n"
  end

  test "4.- Not five " do
    assert CodeGenerator.generate_code(%AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :constant,
                   left_node: nil,
                   right_node: nil,
                   value: 0
                 },
                 right_node: nil,
                 value: nil
               },
               right_node: nil,
               value: :main
             },
             right_node: nil,
             value: nil
           }) == "\n    .section    __TEXT,__text,regular,pure_instructions\n    .p2align    4, 0x90\n\n    .globl  _main     ## --Begin fuction main\n_main:                ## @main\n\n    movl $0, %eax\n    ret\n"
  end

end