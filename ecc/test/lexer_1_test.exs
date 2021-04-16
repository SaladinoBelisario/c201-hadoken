defmodule LexerTest do
  use ExUnit.Case
  # doctest Lexer

  ## Ejecutar antes de que las pruebas se ejecuten
  ## Lista de Tokens Normales
  setup_all do
    {:ok,
     tokens: [
       {:int_keyword,0},
       {:main_keyword,0},
       {:open_paren,0},
       {:close_paren,0},
       {:open_brace,0},
       {:return_keyword,0},
       {{:constant, 2},0},
       {:semicolon,0},
       {:close_brace,0}
     ],
      tokens_0: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 0},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      tokens_multidigit: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 100},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      tokens_not_paren: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 0},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      tokens_not_args: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      tokens_not_brace: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 0},0},
        {:semicolon,0},
      ],
      tokens_bad_return: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:error,"RETURN",0},
        {{:constant, 2},0},
        {:semicolon,0},
        {:close_brace,0}
      ],
      tokens_not_space: [
        {:int_keyword,0},
        {:main_keyword,0},
        {:open_paren,0},
        {:close_paren,0},
        {:open_brace,0},
        {:return_keyword,0},
        {{:constant, 0},0},
        {:semicolon,0},
        {:close_brace,0}
      ]
    }
  end

  ######################################################################################
  IO.puts("Pruebas del lexer (6 pruebas Validas del Nora Sandler) ")

  test "1.- Return 0 ", state do
    assert Lexer.scan_words_test(["int","main(){","return","0;}"]) == state[:tokens_0]
  end

  test "2.- Return 2", state do
    assert Lexer.scan_words_test(["int","main()","{return","2;}"]) == state[:tokens]
  end

  test "3.- Return 100", state do
    assert Lexer.scan_words_test(["int","main","()","{return","100;}"]) == state[:tokens_multidigit]
  end

  test "4.- New lines", state do
    assert Lexer.scan_words_test(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) == state[:tokens]
  end

  test "5.- No new lines", state do
    assert Lexer.scan_words_test(["int","main(){return","2;}"]) == state[:tokens]
  end

  test "6.- Spaces", state do
    assert Lexer.scan_words_test(["int", "main", "(", ")", "{", "return", "100", ";", "}"]) == state[:tokens_multidigit]
  end

  ######################################################################################
  IO.puts("Pruebas no validas")

  test "8.-Missing paren", state do
    assert Lexer.scan_words_test(["int", "main(", "{", "return", "0", ";", "}"]) == state[:tokens_not_paren]
  end

  test "9.-Missing return arg", state do
    assert Lexer.scan_words_test(["int", "main", "(", ")", "{", "return", ";}"]) == state[:tokens_not_args]
  end

  test "10.-Missing brace", state do
    assert Lexer.scan_words_test(["int", "main", "(", ")", "{return", "0", ";"]) == state[:tokens_not_brace]
  end

  test "12.-No space", state do
    assert Lexer.scan_words_test(["int", "main", "(", ")", "{", "return0;", "}"]) == state[:tokens_not_space]
  end

  test "13.-Bad writen return statement", state do
    assert Lexer.scan_words_test(["int", "main", "(", ")", "{", "RETURN","2", ";", "}"]) == state[:tokens_bad_return]
  end
end