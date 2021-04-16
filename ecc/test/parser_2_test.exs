defmodule ParserTest2 do
  use ExUnit.Case
  # doctest Lexer
  # Hay 7 pruebas que serian los
  # casos validos de programas segun Nora
  ######################################################################################
  IO.puts("Pruebas del parser 2a parte (operadores unarios) ")

  test "1.- Bitwise" do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:negative_logical, 0},
             {{:constant, 12}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :negative_logical,
                   left_node: %AST{
                     id: :constant,
                     left_node: nil,
                     right_node: nil,
                     value: 12
                   },
                   right_node: nil,
                   value: nil
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

  test "2.- Bitwise 0 " do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:complement_keyword, 0},
             {{:constant, 0}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :unary_complement,
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
                 value: nil
               },
               right_node: nil,
               value: :main
             },
             right_node: nil,
             value: nil
           }
  end

  test "3.- Negation " do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:negative_keyword, 0},
             {{:constant, 5}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :unary_negative,
                   left_node: %AST{
                     id: :constant,
                     left_node: nil,
                     right_node: nil,
                     value: 5
                   },
                   right_node: nil,
                   value: nil
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

  test "4.- Nested ops" do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:negative_logical, 0},
             {:negative_keyword, 0},
             {{:constant, 3}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :negative_logical,
                   left_node: %AST{
                     id: :unary_negative,
                     left_node: %AST{
                       id: :constant,
                       left_node: nil,
                       right_node: nil,
                       value: 3
                     },
                     right_node: nil,
                     value: nil
                   },
                   right_node: nil,
                   value: nil
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

  test "5.- Nested ops 2" do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:negative_keyword, 0},
             {:complement_keyword, 0},
             {{:constant, 0}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :unary_negative,
                   left_node: %AST{
                     id: :unary_complement,
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
                   value: nil
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

  test "6.- Not Five" do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:negative_logical, 0},
             {{:constant, 5}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :negative_logical,
                   left_node: %AST{
                     id: :constant,
                     left_node: nil,
                     right_node: nil,
                     value: 5
                   },
                   right_node: nil,
                   value: nil
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

  test "5.- Not Zero" do
    assert Parser.parse_program([
             {:int_keyword, 0},
             {:main_keyword, 0},
             {:open_paren, 0},
             {:close_paren, 0},
             {:open_brace, 0},
             {:return_keyword, 0},
             {:negative_logical, 0},
             {{:constant, 0}, 0},
             {:semicolon, 0},
             {:close_brace, 0}
           ]) == %AST{
             id: :program,
             left_node: %AST{
               id: :function,
               left_node: %AST{
                 id: :return,
                 left_node: %AST{
                   id: :negative_logical,
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