defmodule CompilersTest do
  use ExUnit.Case
  doctest Compilers

  setup_all do
    {:ok,
     tokens: [
       :int_keyword,
       :main_keyword,
       :a_parentesis,
       :c_parentesis,
       :a_llave,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :c_llave
     ]}
  end

  setup_all do
    {:ok,
    tokens_multi_digit: [
      :int_keyword,
      :main_keyword,
      :a_parentesis,
      :c_parentesis,
      :a_llave,
      :return_keyword,
      {:constant, 100},
      :semicolon,
      :c_llave
    ]}
  end

  setup_all do
    {:ok,
    tokens_missing_paren: [
      :int_keyword,
      :main_keyword,
      :a_parentesis,
      :a_llave,
      :return_keyword,
      {:constant, 2},
      :semicolon,
      :c_llave
    ]}
  end
    
  setup_all do
      {:ok,
      tokens_missing_retval: [
        :int_keyword,
        :main_keyword,
        :a_parentesis,
        :c_parentesis,
        :a_llave,
        :return_keyword,
        :semicolon,
        :c_llave
      ]}
  end

    setup_all do
      {:ok,
      tokens_no_brace: [
        :int_keyword,
        :main_keyword,
        :a_llave,
        :return_keyword,
        {:constant, 2},
        :semicolon,
      ]}
    end

    setup_all do
      {:ok,
       tokens_no_semicolon: [
         :int_keyword,
         :main_keyword,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :c_llave
       ]}
    end


    setup_all do
      {:ok,
       tokens_bitwise: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 12},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_bitwise_zero: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :complemento,
         {:constant, 0},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_neg: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :negacion,
         {:constant, 5},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_nested_ops: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         :negacion,
         {:constant, 3},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_nested_ops2: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :negacion,
         :complemento,
         {:constant, 0},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_not_five: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 5},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_not_zero: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 0},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_missing_const: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_missing_semicolon: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         {:constant, 5},
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_nested_missing_const: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :logical_negation,
         :complemento,
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_wrong_order: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 4},
         :negacion,
         :semicolon,
         :c_llave
       ]}
    end

    
  ## ***********************      WEEK3   *******************************************

    setup_all do
      {:ok,
       tokens_add: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 1},
         :add,
         {:constant, 2},
         :negacion,
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_associativity: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 1},
         :negacion,
         {:constant, 2},
         :negacion,
         {:constant, 3},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_associativity_2: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 6},
         :div,
         {:constant, 3},
         :div,
         {:constant, 2},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_div: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 4},
         :div,
         {:constant, 2},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_mult: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :mult,
         {:constant, 3},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_parens: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :mult,
         :a_parentesis,
         {:constant, 3},
         :add,
         {:constant, 4},
         :c_parentesis,
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_precedence: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :add,
         {:constant, 3},
         :mult,
         {:constant, 4},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_sub: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 1},
         :negacion,
         {:constant, 2},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_sub_neg: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :negacion,
         :negacion,
         {:constant, 1},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_unop_add: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :complemento,
         {:constant, 2},
         :add,
         {:constant, 3},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_unop_parens: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :complemento,
         :a_parentesis,
         {:constant, 1},
         :add,
         {:constant, 1},
         :c_parentesis,
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_malformed_paren: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 2},
         :a_parentesis,
         :negacion,
         {:constant, 3},
         :c_parentesis,
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_missing_first_op: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         :div,
         {:constant, 3},
         :semicolon,
         :c_llave
       ]}
    end

    setup_all do
      {:ok,
       tokens_missing_second_op: [
         :int_keyword,
         :main_keyword,
         :a_parentesis,
         :c_parentesis,
         :a_llave,
         :return_keyword,
         {:constant, 1},
         :add,
         :semicolon,
         :c_llave
       ]}
    end

  test "elements separated just by spaces", state do
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens]
  end

  test "function name separated of function body", state do
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens]
  end

  test "everything is separated", state do
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) ==
             state[:tokens]
  end

  test "main and body separated", state do 
     assert Lexer.scan_words(["int", "main", "(", ")", "{return2;}"]) == state[:tokens]
  end


  test "todo junto", state do
    assert Lexer.scan_words(["intmain(){return2;}"]) == state[:tokens]
  end

  test "cuerpo_junto" do
    assert Compilers.parser_test(["test/cuerpo_junto.c"]) 
  end

  test "muchos_espacios", state do
    assert Compilers.parser_test(["test/muchos_espacios.c"]) == state[:tokens]
  end
  
  test "muchos_renglones", state do
    assert Compilers.parser_test(["test/muchos_renglones.c"]) == state[:tokens]
  end
  
  test "renglonesespacios", state do
    assert Compilers.parser_test(["test/renglones_espacios.c"]) == state[:tokens]
  end
  



  test "Nora_spaces", state do
    assert Compilers.parser_test(["test/Nora/valid/week1/spaces.c"]) == state[:tokens]
  end

  test "Nora_multi_digit", state do
    assert Compilers.parser_test(["test/Nora/valid/week1/multi_digit.c"]) == state[:tokens_multi_digit]
  end

  test "Nora_newlines", state do
    assert Compilers.parser_test(["test/Nora/valid/week1/newlines.c"]) == state[:tokens]
  end

  test "Nora_no_newlines", state do
    assert Compilers.parser_test(["test/Nora/valid/week1/no_newlines.c"]) == state[:tokens]
  end

  test "Nora_return_2", state do
    assert Compilers.parser_test(["test/Nora/valid/week1/return_2.c"]) == state[:tokens]
  end

  test "Nora_missing_paren", state do
    assert Compilers.parser_test(["test/Nora/invalid/week1/missing_paren.c"]) == state[:tokens_missing_paren]
    #IO.puts("Error: parentesis de cierre no encontrado")
  end

  test "Nora_missing_retval", state do
    assert Compilers.parser_test(["test/Nora/invalid/week1/missing_retval.c"]) == state[:tokens_missing_retval]
  end

  test "Nora_no_brace", state do
    assert Compilers.parser_test(["test/Nora/invalid/week1/no_brace.c"]) == state[:tokens_no_brace]
  end

  test "Nora_no_semicolon", state do
    assert Compilers.parser_test(["test/Nora/invalid/week1/no_semicolon.c"]) == state[:tokens_no_semicolon]
  end

  test "Nora_no_space", state do
    assert Compilers.parser_test(["test/Nora/invalid/week1/no_space.c"]) == state[:tokens]
  end

  test "Nora_wrong_case", state do
    assert Compilers.parser_test(["test/Nora/invalid/week1/wrong_case.c"]) == state[:tokens]
  end


  ## ***********************      WEEK2   *******************************************


  test "Nora_bitwise", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/bitwise.c"]) == state[:tokens_bitwise]
  end

  test "Nora_bitwise_zero", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/bitwise_zero.c"]) == state[:tokens_bitwise_zero]
  end

  test "Nora_neg", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/neg.c"]) == state[:tokens_neg]
  end

  test "Nora_nested_ops", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/nested_ops.c"]) == state[:tokens_nested_ops]
  end

  test "Nora_nested_ops2", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/nested_ops_2.c"]) == state[:tokens_nested_ops2]
  end

  test "Nora_not_five", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/not_five.c"]) == state[:tokens_not_five]
  end

  test "Nora_not_zero", state do
    assert Compilers.parser_test(["test/Nora/valid/week2/not_zero.c"]) == state[:tokens_not_zero]
  end

  test "Nora_missing_const", state do
    assert Compilers.parser_test(["test/Nora/invalid/week2/missing_const.c"]) == state[:tokens_missing_const]
  end

  test "Nora_missing_semicolon", state do
    assert Compilers.parser_test(["test/Nora/invalid/week2/missing_semicolon.c"]) == state[:tokens_missing_semicolon]
  end

  test "Nora_nested_missing_const", state do
    assert Compilers.parser_test(["test/Nora/invalid/week2/nested_missing_const.c"]) == state[:tokens_nested_missing_const]
  end

  test "Nora_wrong_order", state do
    assert Compilers.parser_test(["test/Nora/invalid/week2/wrong_order.c"]) == state[:tokens_wrong_order]
  end


  
  ## ***********************      WEEK3   *******************************************


  #test "Nora_add", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/add.c"]) == state[:tokens_add]
  #end

  #test "Nora_associativity", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/associativity.c"]) == state[:tokens_associativity]
  #end

  #test "Nora_associativity_2", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/associativity_2.c"]) == state[:tokens_associativity_2]
  #end

  #test "Nora_div", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/div.c"]) == state[:tokens_div]
  #end

  #test "Nora_mult", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/mult.c"]) == state[:tokens_mult]
  #end

  #test "Nora_parens", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/parens.c"]) == state[:tokens_parens]
  #end

  #test "Nora_precedence", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/precedence.c"]) == state[:tokens_precedence]
  #end

  #test "Nora_sub", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/sub.c"]) == state[:tokens_sub]
  #end

  #test "Nora_sub_neg", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/sub_neg.c"]) == state[:tokens_sub_neg]
  #end


  #test "Nora_unop_add", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/unop_add.c"]) == state[:tokens_unop_add]
  #end

  #test "Nora_unop_parens", state do
  #  assert Compilers.parser_test(["test/Nora/valid/week3/unop_parens.c"]) == state[:tokens_unop_parens]
  #end


  #test "Nora_malformed_paren", state do
  #  assert Compilers.parser_test(["test/Nora/invalid/week3/malformed_paren.c"]) == state[:tokens_malformed_paren]
  #end

  #test "Nora_missing_first_op", state do
  #  assert Compilers.parser_test(["test/Nora/invalid/week3/missing_first_op.c"]) == state[:tokens_missing_first_op]
  #end

  #test "Nora_missing_second_op", state do
  #  assert Compilers.parser_test(["test/Nora/invalid/week3/missing_second_op.c"]) == state[:tokens_missing_second_op]
  #end



end
