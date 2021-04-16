defmodule SanitizerTest do
  use ExUnit.Case
  # doctest Sanitizer

  setup_all do
    {:ok,
      all_separated_new_lines: [{"int",0},{"main",1},{"(",2},{")",3},{"{",4},{"return",5},{"2",6},{";",7},{"}",8}],
      all_separated_tab: [{"int",0},{"main",0},{"(",0},{")",0},{"{",0},{"return",0},{"2",0},{";",0},{"}",0}],
      main_together: [{"int",0},{"main()",0},{"{",0},{"return",0},{"200",1},{";",1},{"}",1}],
      return_together: [{"int",0},{"main(",0},{")",0},{"{return",0},{"200",1},{";",1},{"}",1}],
      bad_together: [{"intmain(){return2;}",0}]
    }
  end

  ######################################################################################
  IO.puts("Pruebas validas del saneador")

  test "1.- Todo separado con saltos de linea", state do
    code = """
      \nint\nmain\n(\n)\n{\nreturn\n2\n;\n}
    """
    assert Sanitizer.clean_source(code) == state[:all_separated_new_lines]
  end

  test "2.- Todo separado con tabuladores", state do
    code = """
      \tint\tmain\t(\t)\t{\treturn\t2\t;\t}
    """
    assert Sanitizer.clean_source(code) == state[:all_separated_tab]
  end

  test "3.- Todo separado con espacios", state do
    code = """
       int main ( ) { return 2 ; }
    """
    assert Sanitizer.clean_source(code) == state[:all_separated_tab]
  end

  test "4.- Retornando un 200 con prueba mixta(main junto)", state do
    code = """
       \nint\tmain()\t{\treturn\n200 ; }
    """
    assert Sanitizer.clean_source(code) == state[:main_together]
  end

  test "5.- Retornando un 200 con prueba mixta(main junto y return junto)", state do
    code = """
       \nint\tmain(\t)\t{return\n200 ; }
    """
    assert Sanitizer.clean_source(code) == state[:return_together]
  end

  test "6.-Todo junto(una sola palabra) ", state do
    code = """
       intmain(){return2;}
    """
    assert Sanitizer.clean_source(code) == state[:bad_together]
  end
end