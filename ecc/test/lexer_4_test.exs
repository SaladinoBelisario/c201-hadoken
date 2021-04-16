defmodule LexerTest4 do
  use ExUnit.Case
  # doctest Lexer

  ## Ejecutar antes de que las pruebas se ejecuten
  ## Lista de Tokens Normales
  setup_all do
    {:ok,
      and_false: [
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
      ],
      and_true: [
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
      ],
      eq_false: [
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
      ],
      eq_true: [
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
      ],
      ge_false: [
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
      ],
      ge_true: [
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
      ],
      gt_false: [
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
      ],
      gt_true: [
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
      ],
      le_false: [
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
      ],
      le_true: [
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
      ],
      lt_false: [
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
      ],
      lt_true: [
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
      ],
      ne_false: [
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
      ],
      ne_true: [
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
      ],
      or_false: [
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
      ],
      or_true: [
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
      ],
      precedence_1: [
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
      ],
      precedence_2: [
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
      ],
      precedence_3: [
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
      ],
      precedence_4: [
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
      ],
      missing_mid_op: [
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
      ],
      missing_first_op: [
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
      ],
      missing_second_op: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 2},0},
        {:logical_and,0},
        {:close_brace,0}
      ],
      missing_semicolon: [
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
      ]
    }
  end

  ######################################################################################
  IO.puts("Pruebas del lexer 4a parte (20 pruebas Validas del Nora Sandler) ")

  test "1.- And false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","&&","0;","}"]) == state[:and_false]
  end

  test "2.- And true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","&&","-1;","}"]) == state[:and_true]
  end

  test "3.- Equal false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","==","2;","}"]) == state[:eq_false]
  end

  test "4.- Equal true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","==","1;","}"]) == state[:eq_true]
  end

  test "5.- Grater or equal than false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1",">=","2;","}"]) == state[:ge_false]
  end

  test "6.- Greater or equal than true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1",">=","1;","}"]) == state[:ge_true]
  end

  test "7.- Greater than false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1",">","2;","}"]) == state[:gt_false]
  end

  test "8.- Grater than true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1",">","0;","}"]) == state[:gt_true]
  end

  test "9.- Less or equal than false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","<=","-1;","}"]) == state[:le_false]
  end

  test "10.- Less or equal than true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","0","<=","2;","}"]) == state[:le_true]
  end

  test "11.- Less than false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","<","1;","}"]) == state[:lt_false]
  end

  test "12.- Less than true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","<","2;","}"]) == state[:lt_true]
  end

  test "13.- Not equals false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","0","!=","0;","}"]) == state[:ne_false]
  end

  test "14.- Not equals true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","-1","!=","-2;","}"]) == state[:ne_true]
  end

  test "15.- Or false", state do
    assert Lexer.scan_words_test(["int","main()","{","return","0","||","0;","}"]) == state[:or_false]
  end

  test "16.- Or true", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","||","0;","}"]) == state[:or_true]
  end

  test "17.- Precedence 1", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","||","0","&&","2;","}"]) == state[:precedence_1]
  end

  test "18.- Precedence 2", state do
    assert Lexer.scan_words_test(["int","main()","{","return","(1","||","0)","&&","0;","}"]) == state[:precedence_2]
  end

  test "19.- Precedence 3", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","==","2",">","0;","}"]) == state[:precedence_3]
  end

  test "20.- Precedence 4", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","==","2","||","0;","}"]) == state[:precedence_4]
  end

  ######################################################################################
  IO.puts("Pruebas no validas")

  test "21.-Missing first operator", state do
    assert Lexer.scan_words_test(["int","main()","{","return","<=","2;","}"]) == state[:missing_first_op]
  end

  test "22.-Missing semicolon", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","||","2","}"]) == state[:missing_semicolon]
  end

  test "23.-Missing second operator and semicolon", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","&&","}"]) == state[:missing_second_op]
  end

  test "24.-Missing mid operator", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","<",">","3;","}"]) == state[:missing_mid_op]
  end
end