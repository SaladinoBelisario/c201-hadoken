defmodule Optimizer do

  def optimize(ast) do
    optimized = build(ast,ast)
    if ast == optimized do #No hubo optimizaciones
      ast
    else
      optimize(optimized) #Hacemos más rondas
    end
  end

  def build(node ,father) do
    cond do
      node.left_node == nil -> #Se llegó al nodo hoja
        node

      is_unary_op(node) ->
        if flag = can_optimize(node,father) do
          case flag do
            :negative_cero ->
              node.left_node #Eliminamos la negacion y regresamos el cero
            :log_neg_cero ->
              #Eliminamos negacion  logica
              father = %{father | left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 1}}
              father.left_node #Regresamos 1
            :log_neg_number ->
              #Eliminamos negacion logica
              father = %{father | left_node: %AST{id: :constant, left_node: nil, right_node: nil, value: 0}}
              father.left_node #Regresamos 0
            :repeated_operator ->
              father = %{father | value: :delete} #Bandera para eliminar nodo padre posteriormente
              %{father | left_node: node.left_node} #Eliminamos nodo actual
          end
        else
          id = node.id #Guardamos el nombre del operador
          node = build(node.left_node, node) #Obtenemos todo el árbol izquierdo
          if node.value == :delete do
            father = %{father | left_node: node.left_node}#Eliminamos nodo actual
            build(father.left_node, father)#Seguimos analizando
          else
            %AST{id: id, left_node: node, right_node: nil, value: nil}
          end
        end

      is_binary_op(node) ->
        %AST{id: node.id, left_node: build(node.left_node, node), right_node: build(node.right_node, node), value: nil}

      true -> #Nodos :program,:function, :return
        %AST{id: node.id, left_node: build(node.left_node, node), right_node: nil, value: nil}
    end
  end

  def can_optimize(node,father) do
    # Optimizaciones aceptadas
    # !!x = x, si x = 0 | 1
    # --x =  x
    # ~~x =  x
    # -0 = 0
    # !x = 1 si x = 0
    # !x = 0 si x != 0
    cond do
      father.id == node.id and father.left_node == node and node.left_node.id == :constant ->
        if node.id in [:complement_keyword,:negative_keyword] do
          :repeated_operator #--x o ~~x
        else #Es negacion logica
          if node.left_node.value in [0,1] do
            :repeated_operator #!!x
          else
            false
          end
        end
      node.left_node.value == 0 and node.id == :negative_keyword ->
        :negative_cero #-0
      node.left_node.value == 0 and node.id == :negative_logical ->
        :log_neg_cero #!x = 1
      node.left_node.id == :constant and node.id == :negative_logical  and node.left_node.value != 0 ->
        :log_neg_number #!x = 0
      true ->
        false
    end
  end

  def is_unary_op(node) do
    cond do
      node.id == :negative_keyword and node.right_node == nil ->#"-" unario
        true
      node.id in [:complement_keyword,:negative_logical] ->
        true
      true ->
        false
    end
  end

  def is_binary_op(node) do
    cond do
      node.id == :negative_keyword and node.right_node != nil ->#"-" binario
        true
      node.id
      in [:addition,:multiplication,:division,:equal_to,:not_equal_to,
        :greater_than,:greater_or_eq,:less_than,:less_or_eq,:logical_or,:logical_and] ->
        true
      true ->
        false
    end
  end

end