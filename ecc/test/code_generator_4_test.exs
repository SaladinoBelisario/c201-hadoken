defmodule CodeGeneratorTest4 do
  use ExUnit.Case
  # doctest Code Generator test
  # Solo hay 3 pruebas que serian los
  # casos validos de programas segun Nora
  ######################################################################################
  IO.puts("Pruebas del generador de codigo 4a parte")

  test "1.- Addition false" do
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

  test "2.- Equality true" do
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

  test "3.- Greater or equal false" do
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

  test "4.- Greater true " do
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

  test "5.- Less or equal false" do
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

  test "6.- Less true" do
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

  test "7.- Not equal false" do
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

  test "8.- Or true " do
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

  test "9.- Precedence" do
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

end