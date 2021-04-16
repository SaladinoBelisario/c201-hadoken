defmodule ParserTest4 do
  use ExUnit.Case
  # doctest Lexer
  # Hay 7 pruebas que serian los
  # casos validos de programas segun Nora
  ######################################################################################
  IO.puts("Pruebas del parser 4a parte (operadores binarios 2) ")

  test "1.- And false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:logical_and,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_and}
  end

  test "2.- And true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:logical_and,0},
             {:negative_keyword,0},
             {{:constant, 1},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_and}

  end

  test "3.- Equals false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:equal_to,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :equal_to}
  end

  test "4.- Equals true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:equal_to,0},
             {{:constant, 1},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :equal_to}
  end

  test "5.- Greater or equal false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:greater_or_eq,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :greater_or_eq}
  end

  test "6.- Greater or equal true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:greater_or_eq,0},
             {{:constant, 1},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :greater_or_eq}
  end

  test "7.- Greater false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:greater_than,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :greater_than}
  end

  test "8.- Greater true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:greater_than,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :greater_than}
  end

  test "9.- Less or equal false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:less_or_eq,0},
             {:negative_keyword,0},
             {{:constant, 1},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :less_or_eq}
  end

  test "10.- Less or equal true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 0},0},
             {:less_or_eq,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :less_or_eq}

  end

  test "11.- Less false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:less_than,0},
             {{:constant, 1},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :less_than}
  end

  test "12.- Less true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:less_than,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :less_than}
  end

  test "13.- Not equal false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 0},0},
             {:not_equal_to,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :not_equal_to}
  end

  test "14.- Not equal true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:negative_keyword,0},
             {{:constant, 1},0},
             {:not_equal_to,0},
             {:negative_keyword,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :not_equal_to}
  end

  test "15.- Or false" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 0},0},
             {:logical_or,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_or}
  end

  test "16.- Or true" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:logical_or,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_or}
  end

  test "17.- Precedence 1" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:logical_or,0},
             {{:constant, 0},0},
             {:logical_and,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_or}
  end

  test "18.- Precedence 2" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:open_paren,0},
             {{:constant, 1},0},
             {:logical_or,0},
             {{:constant, 0},0},
             {:close_paren,0},
             {:logical_and,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_and}
  end

  test "19.- Precedence 3" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:equal_to,0},
             {{:constant, 2},0},
             {:greater_than,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :equal_to}
  end

  test "20.- Precedence 4" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:equal_to,0},
             {{:constant, 2},0},
             {:logical_or,0},
             {{:constant, 0},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :equal_to}
  end

  test "21.- Missing mid op." do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:less_than,0},
             {:greater_than,0},
             {{:constant, 3},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :less_than}
  end

  test "22.- Missing first op." do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {:less_or_eq,0},
             {{:constant, 2},0},
             {:semicolon,0},
             {:close_brace,0}
           ]) == {:error, "Error: factor (mas elementos)", 0, :less_or_eq}
  end

  test "23.- Missing second op." do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 2},0},
             {:logical_and,0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_and}
  end

  test "24.- Missing semicolon" do
    assert Parser.parse_program([
             {:int_keyword,0},
             {:main_keyword,0},
             {:open_paren,0},
             {:close_paren,0},
             {:open_brace,0},
             {:return_keyword,0},
             {{:constant, 1},0},
             {:logical_or,0},
             {{:constant, 2},0},
             {:close_brace,0}
           ]) == {:error, "Missing semicolon", 0, :logical_or}
  end
end