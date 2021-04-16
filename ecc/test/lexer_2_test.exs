defmodule LexerTest2 do
  use ExUnit.Case
  # doctest Lexer

  ## Ejecutar antes de que las pruebas se ejecuten
  ## Lista de Tokens Normales
  setup_all do
    {:ok,
      bitwise: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {{:constant, 12},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      bitwise_0: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:complement_keyword,0},
        {{:constant, 0},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      negation: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_keyword,0},
        {{:constant, 5},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      nested: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {:negative_keyword,0},
        {{:constant, 3},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      nested_2: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_keyword,0},
        {:complement_keyword,0},
        {{:constant, 0},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      not_five: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {{:constant, 5},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      not_zero: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {{:constant, 0},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      missing_const: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      missing_semicolon: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {{:constant, 5},0},
        {:close_brace,0}
      ],
      missing_nested_const: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:negative_logical,0},
        {:complement_keyword,0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      wrong_order: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 4},0},
        {:negative_keyword,0},
        {:semicolon,0},
        {:close_brace,0}
      ]
    }
  end

  ######################################################################################
  IO.puts("Pruebas del lexer 2a parte (7 pruebas Validas del Nora Sandler) ")

  test "1.- Bitwise", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!12;","}"]) == state[:bitwise]
  end

  test "2.- Bitwise 0", state do
    assert Lexer.scan_words_test(["int","main()","{","return","~0;","}"]) == state[:bitwise_0]
  end

  test "3.- Negation", state do
    assert Lexer.scan_words_test(["int","main()","{","return","-5;","}"]) == state[:negation]
  end

  test "4.- Nested ops", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!-3;","}"]) == state[:nested]
  end

  test "5.- Nested ops 2", state do
    assert Lexer.scan_words_test(["int","main()","{","return","-~0;","}"]) == state[:nested_2]
  end

  test "6.- Not Five", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!5;","}"]) == state[:not_five]
  end

  test "7.- Not Zero", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!0;","}"]) == state[:not_zero]
  end

  ######################################################################################
  IO.puts("Pruebas no validas")

  test "8.-Missing constant", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!;","}"]) == state[:missing_const]
  end

  test "9.-Missing semicolon", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!5","}"]) == state[:missing_semicolon]
  end

  test "10.-Nested missing constant", state do
    assert Lexer.scan_words_test(["int","main()","{","return","!~;","}"]) == state[:missing_nested_const]
  end

  test "12.-Wrong order", state do
    assert Lexer.scan_words_test(["int","main()","{","return","4-;","}"]) == state[:wrong_order]
  end

end