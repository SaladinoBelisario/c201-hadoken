defmodule ParserTest do
  use ExUnit.Case
  # doctest Lexer
  # Solo hay 3 pruebas que serian los
  # casos validos de programas segun Nora
  ######################################################################################
  IO.puts("Pruebas del parser ")

  test "1.- Return 2 " do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{
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
           }
  end

  test "2.- Return 0 " do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{
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
           }
  end

  test "3.- Return 100 " do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 100},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{
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
           }
  end
end