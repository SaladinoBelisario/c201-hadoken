defmodule LexerTest3 do
  use ExUnit.Case
  # doctest Lexer

  ## Ejecutar antes de que las pruebas se ejecuten
  ## Lista de Tokens Normales
  setup_all do
    {:ok,
      addition: [
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
      ],
      associativity: [
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
      ],
      associativity_2: [
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
      ],
      division: [
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
      ],
      division_neg: [
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
      ],
      multiplication: [
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
      ],
      paren: [
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
      ],
      precedence: [
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
      ],
      subtract: [
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
      ],
      subtract_neg: [
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
      ],
      unary_op_addition: [
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
      ],
      unary_op_paren: [
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
      ],
      malformed_paren: [
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
      ],
      missing_first_op: [
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
      ],
      missing_second_op: [
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
      ],
      missing_semicolon: [
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
      ]
    }
  end

  ######################################################################################
  IO.puts("Pruebas del lexer 3a parte (12 pruebas Validas del Nora Sandler) ")

  test "1.- Addition", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","+","2;","}"]) == state[:addition]
  end

  test "2.- Associativity", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","-","2","-","3;","}"]) == state[:associativity]
  end

  test "3.- Associativity 2", state do
    assert Lexer.scan_words_test(["int","main()","{","return","6","/","3","/","2;","}"]) == state[:associativity_2]
  end

  test "4.- Division", state do
    assert Lexer.scan_words_test(["int","main()","{","return","4","/","2;","}"]) == state[:division]
  end

  test "5.- Division neg", state do
    assert Lexer.scan_words_test(["int","main()","{","return","(","-","12",")","/","5;","}"]) == state[:division_neg]
  end

  test "6.- Multiplication", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","*","3;","}"]) == state[:multiplication]
  end

  test "7.- Paren", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","*","(","3","+","4",");","}"]) == state[:paren]
  end

  test "8.- Precedence", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","+","3","*","4;","}"]) == state[:precedence]
  end

  test "9.- Subtract", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","-","2",";","}"]) == state[:subtract]
  end

  test "10.- Subtract neg", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","-","-","1",";","}"]) == state[:subtract_neg]
  end

  test "11.- Unary op add", state do
    assert Lexer.scan_words_test(["int","main()","{","return","~","2","+","3",";","}"]) == state[:unary_op_addition]
  end

  test "12.- Unary op paren", state do
    assert Lexer.scan_words_test(["int","main()","{","return","~","(","1","+","1",")",";","}"]) == state[:unary_op_paren]
  end

  ######################################################################################
  IO.puts("Pruebas no validas")

  test "13.-Malformed paren", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","(","-","3",")",";","}"]) == state[:malformed_paren]
  end

  test "14.-Missing first operator", state do
    assert Lexer.scan_words_test(["int","main()","{","return","/","3",";","}"]) == state[:missing_first_op]
  end

  test "15.-Missing second operator", state do
    assert Lexer.scan_words_test(["int","main()","{","return","1","+",";","}"]) == state[:missing_second_op]
  end

  test "16.-Missing semicolon", state do
    assert Lexer.scan_words_test(["int","main()","{","return","2","*","2","}"]) == state[:missing_semicolon]
  end
end