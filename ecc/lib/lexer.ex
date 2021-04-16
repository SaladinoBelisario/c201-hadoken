defmodule Lexer do
  @moduledoc """
  Actual Lexing Symbols
    Open brace '{'
    Close brace '}'
    Open parenthesis '('
    Close parenthesis ')'
    Semicolon ';'
    Int keyword 'int'
    Return keyword 'return'
    Identifier '[a-zA-Z]\w*'
    Integer literal '[0-9]+'
    Minus '-'
    Bitwise complement '~'
    Logical negation '!'
    Addition '+'
    Multiplication '*'
    Division '/'
    AND '&&'
    OR '||'
    Equal '=='
    Not Equal '!='
    Less than '<'
    Less than or equal '<='
    Greater than '>'
    Greater than or equal '>='
  """

  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

	def scan_words_test(words) do
		map_fun = fn(word) -> lex_raw_tokens({word,0}) end
		Enum.flat_map(words, map_fun)
	end

  def get_constant(program,linea) do
		valor=Regex.run(~r/^\d+/, program)
		if valor != :nil do
			case valor do
				[value] ->
				{{{:constant, String.to_integer(value)},linea}, String.trim_leading(program, value)}
			end
		else
			{{:error, program, linea},""}
		end
  end

  def lex_raw_tokens({program,linea}) when program != "" do
    linea_keyword=linea
    {token, rest} =
      case program do

        "{" <> rest ->
          {{:open_brace,linea_keyword}, rest}

        "}" <> rest ->
          {{:close_brace,linea_keyword}, rest}

        "(" <> rest ->
          {{:open_paren,linea_keyword}, rest}

        ")" <> rest ->
          {{:close_paren,linea_keyword}, rest}

        ";" <> rest ->
          {{:semicolon, linea_keyword}, rest}

        "return" <> rest ->
          {{:return_keyword, linea_keyword}, rest}

        "int" <> rest ->
          {{:int_keyword, linea_keyword}, rest}

        "main" <> rest ->
          {{:main_keyword, linea_keyword}, rest}

        "-" <> rest ->
          {{:negative_keyword, linea_keyword}, rest}

        "~" <> rest ->
          {{:complement_keyword, linea_keyword}, rest}

        "<=" <> rest->
          {{:less_or_eq, linea_keyword}, rest}

        ">=" <> rest->
          {{:greater_or_eq, linea_keyword}, rest}

        "!=" <> rest->
          {{:not_equal_to, linea_keyword}, rest}

        "==" <> rest->
          {{:equal_to, linea_keyword}, rest}

        "||" <> rest->
          {{:logical_or, linea_keyword}, rest}

        "&&" <> rest->
          {{:logical_and, linea_keyword}, rest}

        "!" <> rest ->
          {{:negative_logical, linea_keyword}, rest}

        "+" <> rest ->
          {{:addition, linea_keyword}, rest}

        "*" <> rest ->
          {{:multiplication, linea_keyword}, rest}

        "/" <> rest ->
          {{:division, linea_keyword}, rest}

        "<" <> rest->
          {{:less_than, linea_keyword}, rest}

        ">" <> rest->
          {{:greater_than, linea_keyword}, rest}

        rest ->
          get_constant(rest,linea)
      end
      
      if rest != "" do
        aux_token={rest,linea}
        remaining_tokens=lex_raw_tokens(aux_token)
        [token | remaining_tokens]
	    else
        remaining_tokens=lex_raw_tokens(rest)
        [token | remaining_tokens]
	    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end

