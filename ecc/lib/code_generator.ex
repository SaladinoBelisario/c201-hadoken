defmodule CodeGenerator do
  @moduledoc false
  def generate_code(ast) do
    output = post_order(ast)
  end

  def post_order(ast) do
    case ast do
      nil ->
        nil

      ast ->
        fragment = post_order(ast.left_node)
        post_order(ast.right_node)
        generate_fragment(ast.id, fragment, ast.value)
    end
  end

  def generate_fragment(:program, fragment, _) do
    """

        .section    __TEXT,__text,regular,pure_instructions
        .p2align    4, 0x90
    """ <>
    fragment
  end

  def generate_fragment(:function, fragment, :main) do
    """

        .globl  _main     ## --Begin fuction main
    _main:                ## @main
    """ <>
    fragment
  end

  def generate_fragment(:return, fragment, _) do
    """

        movl #{fragment}, %eax
        ret
    """
  end

  def generate_fragment(:constant, fragment, value) do
    "$#{value}"
  end

  def generate_fragment(:unary_negative, fragment, _) do
    if Regex.match?(~r{    _NEGOP\n}, fragment) do #¿Se trata del operador "-" unario?
      Regex.replace(~r{    _NEGOP\n}, fragment, "    neg    %rax\n") #Borramos la linea y sustituimos por la instrucción unaria
    else #Se trata del operador "-" binario. Agregamos instrucciones
      fragment <>
      """
          sub    %rax, %rbx
          mov    %rbx, %rax
      """
    end
  end

  def generate_fragment(:unary_complement, fragment, _) do
    fragment <>
    """
        not    %eax
    """
  end

  def generate_fragment(:negative_logical, fragment, _) do
    fragment <>
    """
        cmpl   $0, %eax
        movl   $0, %eax
        sete   %al
    """
  end

  def generate_fragment(:addition, fragment, _) do
    fragment <>
    """
        add    %rbx, %rax
    """
  end

  def generate_fragment(:multiplication, fragment, _) do
    fragment <>
    """
        imul    %rbx, %rax
    """
  end

  def generate_fragment(:division, fragment, _) do
    fragment <>
    """
        push    %rax
        mov    %rbx, %rax
        pop    %rbx
        cqo
        idivq    %rbx
    """
  end

  def generate_fragment(:equal_to, fragment, _) do
    fragment <>
    """
        cmp    %rax, %rbx
        mov    $0, %rax
        sete    %al
    """
  end

  def generate_fragment(:not_equal_to, fragment, _) do
    fragment <>
    """
        cmp    %rax, %rbx
        mov    $0, %rax
        setne    %al
    """
  end

  def generate_fragment(:greater_than, fragment, _) do
    fragment <>
    """
        cmp    %rax, %rbx
        mov    $0, %rax
        setg    %al
    """
  end

  def generate_fragment(:less_than, fragment, _) do
    fragment <>
    """
        cmp    %rax, %rbx
        mov    $0, %rax
        setl    %al
    """
  end

  def generate_fragment(:greater_or_eq, fragment, _) do
    fragment <>
    """
        cmp    %rax, %rbx
        mov    $0, %rax
        setge    %al
    """
  end

  def generate_fragment(:less_or_eq, fragment, _) do
    fragment <>
    """
        cmp    %rax, %rbx
        mov    $0, %rax
        setle    %al
    """
  end

  def generate_fragment(:logical_or, fragment, _) do
    jump_number = pop_unconditional_jump_number()

    fragment <>
    """
        cmp    $0, %rax
        mov    $0, %rax
        setne    %al
    _shortcircuit#{jump_number}:
    """
  end

  def generate_fragment(:logical_and, fragment, _) do
    jump_number = pop_unconditional_jump_number()

    fragment <>
    """
        cmp    $0, %rax
        mov    $0, %rax
        setne    %al
    _shortcircuit#{jump_number}:
    """
  end

  def get_jump_number() do
    if File.exists?("jump_labels") do
      stack = File.read!("jump_labels")
      jump_number =
        String.split(stack, "\n")#Obtiene el ultimo numero de salto registrado
        |> List.last()
        |> String.to_integer()
        |> Kernel.+(1) #Sumamos uno, es decir un nuevo numero de salto
      File.write("jump_labels", "\n#{jump_number}", [:append])#Hace "push" del nuevo numero de salto
      jump_number
    else #Es el primer salto a registrar
      File.write("jump_labels", "1")
      1
    end
  end

  def get_unconditional_jump_number() do
    if File.exists?("uncond_jump_labels") do
      stack = File.read!("uncond_jump_labels")
      jump_number = #Obtiene el ultimo numero de salto registrado
        String.split(stack, "\n")
        |> List.last()
        |> String.to_integer()
        |> Kernel.+(1) #Sumamos uno, es decir un nuevo numero de salto
      File.write("uncond_jump_labels", "\n#{jump_number}", [:append])#Hace "push" del nuevo numero de salto
      jump_number
    else #Es el primer salto a registrar
      File.write("uncond_jump_labels", "1")
      1
    end
  end

  def pop_unconditional_jump_number() do
    stack = File.read!("uncond_jump_labels")
    jump_number =
      String.split(stack, "\n") #Hace"pop" del ultimo numero de salto registrado
      |> List.last()
    stack = String.split(stack, "\n") |> Enum.reverse |> tl() |> Enum.reverse()#Nuevo stack despues del "pop"
    stack = stack_to_string(stack, "") #Conversion del stack a cadena
    if stack != "" do
      File.write("uncond_jump_labels", stack)
    else #El stack ha quedado vacio. Por tanto, registramos un nuevo numero de salto por si se requiere posteriormente
      File.write("uncond_jump_labels", "#{jump_number |> String.to_integer() |> Kernel.+(1)}")
    end
    jump_number
  end

  def stack_to_string(stack, substring) do #Convierte un stack a cadena
    if length(stack) != 0 do
      stack_to_string(tl(stack), substring <> hd(stack) <> "\n")
    else
      hd Regex.split(~r{(?s)\n(?!.*\n)}, substring) #Quita el ultimo salto de linea
    end
  end

  def push_operand?(node) do #Hace push del operando izquierdo para recuperarlo más tarde cuando se hace la operación
    if is_bin_operator(node.id) do
      cond do
        node.id == :unary_negative and node.right_node == nil -> #Es la operacion "-"" unaria, no hay que hacer push
          #Sólo indicamos que es un menos unario
          """
              _NEGOP
          """
        node.id == :logical_or ->
          jump_number_1 = get_jump_number()
          jump_number_2 = get_unconditional_jump_number()

          """
              cmp    $0, %rax
              je    _jump#{jump_number_1}
              mov    $1, %rax
              jmp    _shortcircuit#{jump_number_2}
          _jump#{jump_number_1}:
          """
        node.id == :logical_and ->
          jump_number_1 = get_jump_number()
          jump_number_2 = get_unconditional_jump_number()

          """
              cmp    $0, %rax
              jne    _jump#{jump_number_1}
              jmp    _shortcircuit#{jump_number_2}
          _jump#{jump_number_1}:
          """
        true -> #Guardamos el operando en stack
          """
              push    %rax
          """
      end
    else
      ""
    end
  end

  def pop_operand?(node) do
    if is_bin_operator(node.id) do
      cond do
        node.id == :unary_negative and node.right_node == nil ->#Es la operacion "-"" unaria
          ""
        node.id == :logical_or or node.id == :logical_and ->
          ""
        true -> #Recuperamos el operando para hacer la operación
          """
              pop    %rbx
          """
      end
    else
      ""
    end
  end

  def is_bin_operator(id) do
    if id
       in [:addition, :unary_negative, :multiplication, :division, :equal_to, :not_equal_to,
      :greater_than, :greater_or_eq, :less_than, :less_or_eq, :logical_or, :logical_and] do
      true
    else
      false
    end
  end

  #Para cualquier funcion que no sea la principal
  #def generateFragment(:function, fragment, name) do
  # """
  #
  #        .globl  _#{name}    ## --Begin fuction #{name}
  #    _#{name}:                ## @#{name}
  #    """<>
  #    fragment
  #end
end
