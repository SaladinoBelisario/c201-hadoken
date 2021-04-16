defmodule Parser do

  @moduledoc """
  Actual Grammar
  <program> ::= <function>
  <function> ::= "int" <id> "(" ")" "{" <statement> "}"
  <statement> ::= "return" <exp> ";"
  <exp> ::= <logical-and-exp> { "||" <logical-and-exp> }
  <logical-and-exp> ::= <equality-exp> { "&&" <equality-exp> }
  <equality-exp> ::= <relational-exp> { ("!=" | "==") <relational-exp> }
  <relational-exp> ::= <additive-exp> { ("<" | ">" | "<=" | ">=") <additive-exp> }
  <additive-exp> ::= <term> { ("+" | "-") <term> }
  <term> ::= <factor> { ("*" | "/") <factor> }
  <factor> ::= "(" <exp> ")" | <unary_op> <factor> | <int>
  <unary_op> ::= "!" | "~" | "-"
  """
  def parse_program(token_list) do
    function = parse_function(token_list,0)
    case function do
      {{:error, error_message, linea, problem}, _rest} ->
        {:error, error_message, linea, problem}
      {function_node, rest} ->
        if rest == [] do
          %AST{id: :program, left_node: function_node}
        else
          {:error, "Error: hay mas elementos al final de la funcion",0,"mas elementos"}
        end
    end
  end

  def parse_function([{next_token,num_line} | rest],count) do
    if rest != [] do
      case count do
        0->
          if next_token == :int_keyword do
            count=count+1
            parse_function(rest,count)
          else
            {{:error, "Missing int keyword",num_line,next_token},rest}
          end
        1->
          if next_token == :main_keyword do
            count=count+1
            parse_function(rest,count)
          else
            {{:error, "Missing main function",num_line,next_token},rest}
          end
        2->
          if next_token == :open_paren do
            count=count+1
            parse_function(rest,count)
          else
            {{:error, "Missing open paren",num_line,next_token},rest}
          end
        3->
          if next_token == :close_paren do
            count=count+1
            parse_function(rest,count)
          else
            {{:error, "Missing close paren",num_line,next_token},rest}
          end
        4->
          if next_token == :open_brace do
            statement = parse_statement(rest)
            case statement do
              {{:error, error_message,num_line,next_token}, rest} ->
                {{:error, error_message,num_line,next_token}, rest}

              {statement_node,remaining_list} ->
                [{next_token,num_line}|rest]=remaining_list
                if next_token == :close_brace do
                  {%AST{id: :function, value: :main, left_node: statement_node}, rest}
                else
                  {{:error, "Missing open brace",num_line,next_token}, rest}
                end
            end
          end
        end
      else
        {{:error, "Not identified error",num_line,next_token}, []}
      end
  end



  def parse_statement([{next_token,num_line} | rest]) do
      if next_token == :return_keyword do
        expression = parse_expression(rest,1)
        case expression do
          {{:error, error_message,num_line,next_token}, rest} ->
            {{:error, error_message,num_line,next_token}, rest}

              {exp_node,remaining_list} ->
              [{next_token,num_line}|rest]=remaining_list
           
           if next_token == :semicolon do
              {%AST{id: :return, left_node: exp_node}, rest}
            else
              {{:error, "Missing semicolon",num_line,next_token}, rest}
            end
        end
      else
        {{:error, "Mising close brace",num_line,next_token}, rest}
      end
  end

  def parse_expression(token_list, cExp) do
    [{next_token,num_line} | rest]=token_list

      term = parse_term(token_list,1)
      {expression_node,remaining_list}=term
      [{next_tok,num_line}|rest]=remaining_list
      case next_tok do
      :addition ->
        sTree=%AST{id: :addition}
        top = parse_expression(rest,1)
        {node,remaining_list}=top
        [{next_tok,num_line}|restop]=remaining_list
        {%{sTree | left_node: expression_node, right_node: node }, remaining_list}
      :negative_keyword->
        sTree=%AST{id: :rest}
        top = parse_expression(rest,1)
        {node,remaining_list}=top
      [{next_tok,num_line}|restop]=remaining_list
      {%{sTree | left_node: expression_node, right_node: node }, remaining_list}
      
      _->
      term
    end
  end

  def parse_logical_and_exp([next_tk | rest]) do
    equality_expression = parse_equality_exp([next_tk | rest])
    case equality_expression do
      {{:error, error_message}, rest} ->
        {{:error, error_message}, rest}

      {left_node, [next_tk2 | rest2]} ->
        if elem(next_tk2, 1) == :logical_and do
          equ_exp_2 = parse_equality_exp(rest2) #se obtiene la expresion derecha de la operacion
          case equ_exp_2 do
            {{:error, error_message}, rest3} ->
              {{:error, error_message}, rest3}

            {other_equ_exp, rest3} -> #Si no hay error devolvemos el arbol
              node = {%AST{id: elem(next_tk2, 1), left_node: left_node, right_node: other_equ_exp}, rest3} #(a +|- b) Se convierte en el primer nodo
              while_bin_op(node)
          end
        else
          {left_node, [next_tk2 | rest2]}
        end
    end
  end

  def parse_equality_exp([next_tk | rest]) do
    relational_expression = parse_relational_exp([next_tk | rest])
    case relational_expression do
      {{:error, error_message}, rest} ->
        {{:error, error_message}, rest}

      {left_node, [next_tk2 | rest2]} ->
        if elem(next_tk2, 1) == :equal_to or elem(next_tk2, 1) == :not_equal_to do
          {other_relat_exp, rest3} = parse_relational_exp(rest2) #se obtiene la expresion derecha de la operacion
          case other_relat_exp do
            {:error, error_message} ->
              {{:error, error_message}, rest3}

            _ -> #Si no hay error devolvemos el arbol
              node = {%AST{id: elem(next_tk2, 1), left_node: left_node, right_node: other_relat_exp}, rest3} #(a +|- b) Se convierte en el primer nodo
              while_bin_op(node)
          end
        else
          {left_node, [next_tk2 | rest2]}
        end
    end
  end

  def parse_relational_exp([next_tk | rest]) do
    additive_expression = parse_additive_exp([next_tk | rest])
    case additive_expression do
      {{:error, error_message}, rest} ->
        {{:error, error_message}, rest}

      {left_node, [next_tk2 | rest2]} ->
        if elem(next_tk2, 1) == :less_than or elem(next_tk2, 1) == :greater_than
           or elem(next_tk2, 1) == :less_or_eq or elem(next_tk2, 1) == :greater_or_eq do
          {other_add_exp, rest3} = parse_additive_exp(rest2) #se obtiene la expresion derecha de la operacion
          case other_add_exp do
            {:error, error_message} ->
              {{:error, error_message}, rest3}

            _ -> #Si no hay error devolvemos el arbol
              node = {%AST{id: elem(next_tk2, 1), left_node: left_node, right_node: other_add_exp}, rest3} #(a +|- b) Se convierte en el primer nodo
              while_bin_op(node)
          end
        else
          {left_node, [next_tk2 | rest2]}
        end
    end
  end

  def parse_additive_exp([next_tk | rest]) do
    case elem(next_tk, 1) do
      :semicolon ->
        {{:error,
          "Line: #{elem(next_tk, 0)}. Error: expected expression before ';' token"}, rest}
      _ ->
        term = parse_term(next_tk , rest)
        case term do
          {{:error, error_message}, rest} ->
            {{:error, error_message}, rest}

          {left_node, [next_tk2 | rest2]} ->
            if elem(next_tk2, 1) == :addition or elem(next_tk2, 1) == :minus_op do
              {other_term, rest3} = parse_term(rest2,rest2) #se obtiene la expresion derecha de la operacion
              case other_term do
                {:error, error_message} ->
                  {{:error, error_message}, rest3}

                _ -> #Si no hay error devolvemos el arbol
                  node = {%AST{id: elem(next_tk2, 1), left_node: left_node, right_node: other_term}, rest3} #(a +|- b) Se convierte en el primer nodo
                  while_bin_op(node)
              end
            else
              {left_node, [next_tk2 | rest2]}
            end
        end
    end
  end

  def parse_term(ast_tree, cTerm) do
    [{next_token,num_line} | rest]=ast_tree
          factor = parse_factor(ast_tree)
          {expression_node,remaining_list}=factor
          [{sig_tok,num_line}|rest]=remaining_list
          case sig_tok do
          :multiplication ->
            sTree=%AST{id: :multiplication}
            top = parse_expression(rest,1)
            {node,remaining_list}=top
            [{sig_tok,num_line}|restop]=remaining_list
            {%{sTree | left_node: expression_node, right_node: node }, remaining_list}
          :division->
            sTree=%AST{id: :division}
            top = parse_expression(rest,1)
            {node,remaining_list}=top
            [{sig_tok,num_line}|restop]=remaining_list
            {%{sTree | left_node: expression_node, right_node: node }, remaining_list}
          _->
            factor
          end
  end

  def parse_factor(ast) do
      [{next_token,num_line} | rest]=ast
      case next_token do
        :open_paren->
          if next_token==:open_paren do
            expression=parse_expression(rest,1)
            case expression do
              {{:error, error_message}, rest} ->
                  {{:error, error_message}, rest}

              {expression_node,remaining_list} ->
                    [{next_token,num_line}|rest]=remaining_list
                if next_token == :close_paren do
                    {expression_node, rest}
                  else
                    express=parse_expression(rest,1)
                    {node_expression,remaining_list_expression}=expression
                    {node,remaining_list_node}=express
                    [_|lista_sin_open_parent]=remaining_list_node
                    {%{node_expression | left_node: node}, lista_sin_open_parent}
                  end
            end
          else
            {{:error, "Error: factor '(' ",num_line,next_token}, rest}
          end
          :complement_keyword->
        unary_op([{next_token,num_line} | rest])
          :negative_keyword->
        unary_op([{next_token,num_line} | rest])
          :negative_logical ->
        unary_op([{next_token,num_line} | rest])

        {:constant, value} ->

          {%AST{id: :constant, value: value}, rest}
        _->
        {{:error, "Error: factor (mas elementos)",num_line,next_token}, rest}

      end
  end

  def unary_op([{next_token,num_line} | rest]) do
    case next_token do
      :negative_keyword ->
        parexpres=parse_factor(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{id: :unary_negative, left_node: nodo}, rest_necesario}
      :complement_keyword ->
        parexpres=parse_factor(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{id: :unary_complement, left_node: nodo}, rest_necesario}
      :negative_logical ->
        parexpres=parse_factor(rest)
        {nodo,rest_necesario}=parexpres
        {%AST{id: :negative_logical, left_node: nodo}, rest_necesario}
      _ -> {{:error, "Error en arbol 1",num_line,next_token}, rest}
    end
  end

  def while_bin_op({left_node, [next_tk | rest]}) do
    if elem(next_tk, 1) == :addition or elem(next_tk, 1) == :minus_op do
      {right_node, rest3} = parse_term(rest,rest)
      node = {%AST{id: elem(next_tk, 1), left_node: left_node, right_node: right_node}, rest3}
      while_bin_op(node)
    else
      if elem(next_tk, 1) == :multiplication or elem(next_tk, 1) == :division_op do
        {right_node, rest3} = parse_factor(rest)
        node = {%AST{id: elem(next_tk, 1), left_node: left_node, right_node: right_node}, rest3}
        while_bin_op(node)
      else
        if elem(next_tk, 1) == :logical_or do
          {right_node, rest3} = parse_logical_and_exp(rest)
          node = {%AST{id: elem(next_tk, 1), left_node: left_node, right_node: right_node}, rest3}
          while_bin_op(node)
        else
          if elem(next_tk, 1) == :logical_and do
            {right_node, rest3} = parse_equality_exp(rest)
            node = {%AST{id: elem(next_tk, 1), left_node: left_node, right_node: right_node}, rest3}
            while_bin_op(node)
          else
            if elem(next_tk, 1) == :equal_to or elem(next_tk, 1) == :not_equal_to do
              {right_node, rest3} = parse_relational_exp(rest)
              node = {%AST{id: elem(next_tk, 1), left_node: left_node, right_node: right_node}, rest3}
              while_bin_op(node)
            else
              if elem(next_tk, 1) == :greater_than or elem(next_tk, 1) == :less_than
                 or elem(next_tk, 1) == :less_or_eq or elem(next_tk, 1) == :greater_or_eq do
                {right_node, rest3} = parse_additive_exp(rest)
                node = {%AST{id: elem(next_tk, 1), left_node: left_node, right_node: right_node}, rest3}
                while_bin_op(node)
              else
                case elem(next_tk, 1) do
                  {:constant, value} ->
                    {{:error,
                      "Line: #{elem(next_tk, 0)}. Error: expected expression before constant #{value}"}, rest}
                  _ ->
                    {left_node, [next_tk | rest]}
                end
              end
            end
          end
        end
      end
    end
  end

end
