defmodule PrettyPrinting do 
	def aux(tree) do
		case tree do
		{:error, error_message} ->
        {:error, error_message}
        _ ->
		cont = 0 #Auxiliar para contar espacios entre nodos
		i = 0 #Auxiliar para el bucle for
		body(tree, cont, i) #Esta función imprime el árbol, pero...
		tree #...hay que regresar el árbol como llego para el Code Generator
		end
	end

	def body(tree, cont, i) do
		if tree != nil do
			body(tree.right_node, cont + 1, i)
			cicle(cont, i)
			printing(tree)
			body(tree.left_node, cont + 1, i)
		end
	end

	def cicle(cont, i) do
		if i < cont do
			IO.write("   ")
			i = i + 1
			cicle(cont, i)
		end
	end

	def printing(tree) do
		if tree.value == nil do 
			IO.write("#{tree.node_name}\n")
		else
			IO.write("#{tree.value}\n")		
		end
	end
end

