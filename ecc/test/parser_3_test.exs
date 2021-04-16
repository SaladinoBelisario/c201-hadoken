defmodule ParserTest3 do
  use ExUnit.Case
  # doctest Lexer
  # Hay 7 pruebas que serian los
  # casos validos de programas segun Nora
  ######################################################################################
  IO.puts("Pruebas del parser 3a parte (operadores binarios) ")

  test "1.- Addition" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:addition,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :addition, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}}}}}
  end

  test "2.- Associativity" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:negative_keyword,0},
             {{:constant, 2},0},
             {:negative_keyword,0},
             {{:constant, 3},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :rest, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}, right_node: %AST{id: :rest, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 3}, value: nil}}}}}
  end

  test "3.- Associativity 2" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 6},0},
             {:division,0},
             {{:constant, 3},0},
             {:division,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :division, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 6}, right_node: %AST{id: :division, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 3}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, value: nil}}}}}
  end

  test "4.- Division" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 4},0},
             {:division,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :division, left_node: %AST{right_node: nil, id: :constant, left_node: nil, value: 4}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}}}}}
  end

  test "5.- Division neg" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:open_paren,0},
             {:negative_keyword,0},
             {{:constant, 12},0},
             {:close_paren,0},
             {:division,0},
             {{:constant, 5},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :division, left_node: %AST{right_node: nil, value: nil, id: :unary_negative, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 12}}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 5}}}}}
  end

  test "6.- Multiplication" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:multiplication,0},
             {{:constant, 3},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :multiplication, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 3}}}}}
  end

  test "7.- Paren" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:multiplication,0},
             {:open_paren,0},
             {{:constant, 3},0},
             {:addition,0},
             {{:constant, 4},0},
             {:close_paren,0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :multiplication, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, right_node: %AST{id: :addition, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 3}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 4}, value: nil}}}}}
  end

  test "8.- Precedence" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:addition,0},
             {{:constant, 3},0},
             {:multiplication,0},
             {{:constant, 4},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, value: nil, id: :addition, right_node: %AST{id: :multiplication, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 3}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 4}, value: nil}}}}}

  end

  test "9.- Subtract" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:negative_keyword,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :rest, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}}}}}
  end

  test "10.- Subtract neg" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:negative_keyword,0},
             {:negative_keyword,0},
             {{:constant, 1},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :rest, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, right_node: %AST{id: :unary_negative, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}, right_node: nil, value: nil}}}}}
  end

  test "11.- Unary op. addition" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:complement_keyword,0},
             {{:constant, 2},0},
             {:addition,0},
             {{:constant, 3},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{value: nil, id: :addition, left_node: %AST{right_node: nil, id: :unary_complement, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 2}, value: nil}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 3}}}}}
  end

  test "12.- Unary op. paren" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:complement_keyword,0},
             {:open_paren,0},
             {{:constant, 1},0},
             {:addition,0},
             {{:constant, 1},0},
             {:close_paren,0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == %AST{id: :program, right_node: nil, value: nil, left_node: %AST{id: :function, right_node: nil, value: :main, left_node: %AST{id: :return, right_node: nil, value: nil, left_node: %AST{right_node: nil, value: nil, id: :unary_complement, left_node: %AST{id: :addition, left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}, right_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}, value: nil}}}}}
  end

  test "13.- Malformed paren" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:open_paren,0},
             {:negative_keyword,0},
             {{:constant, 3},0},
             {:close_paren,0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :open_paren}
  end

  test "14.- Missing first op." do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:division,0},
             {{:constant, 3},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Error: factor (mas elementos)", 0, :division}
  end

  test "15.- Missing second op." do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:addition,0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :close_brace}
  end

  test "16.- Missing semicolon" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:multiplication,0},
             {{:constant, 2},0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :close_brace}
  end
end