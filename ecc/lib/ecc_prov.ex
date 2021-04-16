defmodule ECC do
    import IO.ANSI

    def main(args) do
        cond do
            Enum.empty?(args) ->
                IO.puts(red() <> "Arguments required. See 'ecc -h' for help")
            List.last(args) == "-h" and length(args) == 1 ->
                print_help_message()
            Regex.match?(~r{\w+.c}, List.last(args)) ->
                if File.exists?(List.last(args)) do
                    case args do
                        [file_path] ->
                            compile(file_path, :normal)
                        ["-p", file_path] ->
                            compile(file_path, :optimized)
                        ["-t", file_path] ->
                            print_tokens(file_path)
                        ["-a", file_path] ->
                            print_ast(file_path, :normal)
                        ["-ap", file_path] ->
                            print_ast(file_path, :optimized)
                        ["-c", file_path] ->
                            print_code_gen(file_path, :normal)
                        ["-cp", file_path] ->
                            print_code_gen(file_path, :optimized)
                        ["-o", new_name, file_path] ->
                            compile_new_path(file_path, new_name, :normal)
                        ["-op", new_name, file_path] ->
                            compile_new_path(file_path, new_name, :optimized)
                        _ ->
                            IO.puts(red() <> "Incorrect flag input. See 'ecc -h' for help")
                    end
                else
                    IO.puts(red() <> "C file does not exists. See 'ecc -h' for help")
                end
            true ->
                IO.puts(red() <> "Incorrect input. See 'ecc -h' for help")
        end
    end

    def print_ast(file_path, option) do
        try do
            case option do
                :normal ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> PrettyPrinting.aux()
                :optimized ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> Optimizer.optimize()
                    |> PrettyPrinting.aux()
            end
        rescue
            _error -> IO.puts(red() <> "An error ocurred while printing the abstract syntax tree")
        end
    end

    def print_code_gen(file_path, option) do
        try do
            case option do
                :normal ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> CodeGenerator.generate_code()
                :optimized ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> Optimizer.optimize()
                    |> CodeGenerator.generate_code()
            end
        rescue
            _error -> IO.puts(red() <> "An error ocurred while printing the abstract syntax tree")
        end
    end

    def print_tokens(file_path) do
        try do
            map =
              File.read!(file_path)
              |> Sanitizer.clean_source()
              |> Lexer.scan_words()
            IO.puts("Line\tToken\n")
            Enum.map(map, fn {token, line} -> print_token({token, line}) end)
        rescue
            _error -> IO.puts(red() <> "An error ocurred while printing the token list")
        end
    end

    defp print_token({token, line}) do
        try do
            IO.puts "#{token}\t#{line}"
        rescue #Es una constante
            _error -> IO.puts "#{line}\tconstant: #{Enum.at(Tuple.to_list(token), 1)}"
        end
    end

    def compile(file_path, option) do
        IO.puts("Compiling file: "<> file_path)
        assembly_path = String.replace_trailing(file_path, ".c", ".s")
        output_path = out_path(file_path) #Devolvemos la ruta completa del archivo
        try do
            case option do
                :normal ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> lex_error()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> CodeGenerator.generate_code()
                    |> Linker.generate_binary(assembly_path)
                    {_status, output} = System.cmd(output_path, [])
                    IO.puts(green() <> "Program finished with exit code #{output} \n" <> "Generated executable: #{output_path} ")
                :optimized ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> lex_error()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> Optimizer.optimize()
                    |> CodeGenerator.generate_code()
                    |> Linker.generate_binary(assembly_path)
                    {_status, output} = System.cmd(output_path, [])
                    IO.puts(green() <> "Program finished with exit code #{output} \n" <> "Generated executable: #{output_path} ")
            end
        rescue
            _error -> IO.puts(red() <> "An error ocurred while compiling your file")
        end
    end

    def compile_new_path(file_path, new_path, option) do
        IO.puts("Compiling file: "<> file_path)
        output_path = out_path(file_path, new_path)
        assembly_path = output_path <> ".s"
        try do
            case option do
                :normal ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> lex_error()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> CodeGenerator.generate_code()
                    |> Linker.generate_binary(assembly_path)
                    {_status, output} = System.cmd(output_path, [])
                    IO.puts(green() <> "Program finished with exit code #{output} \n" <> "Generated executable: #{output_path} ")
                :optimized ->
                    File.read!(file_path)
                    |> Sanitizer.clean_source()
                    |> Lexer.scan_words()
                    |> lex_error()
                    |> Parser.parse_program()
                    |> parse_error()
                    |> Optimizer.optimize()
                    |> CodeGenerator.generate_code()
                    |> Linker.generate_binary(assembly_path)
                    {_status, output} = System.cmd(output_path, [])
                    IO.puts(green() <> "Program finished with exit code #{output} \n" <> "Generated executable: #{output_path} ")
            end
        rescue
            _error -> IO.puts(red() <> "An error ocurred while compiling your file")
        end
    end

    def print_help_message() do
        IO.puts(yellow() <> bright() <> "\n|===|===|===|===|===|===|>>>||Ecc help menu||<<<|===|===|===|===|===|===|")
        IO.puts(blue() <> bright() <> "\nThe C compiler supports the following options:\n")
        options =
          [{green() <> bright() <> "ecc file.c", white() <> normal() <> "Compiles the C file generating binary"},
              {green() <> bright() <> "ecc -t file.c", white() <> normal() <> "Prints the C file tokens"},
              {green() <> bright() <> "ecc -a file.c", white() <> normal() <> "Prints the AST tree for this C file"},
              {green() <> bright() <> "ecc -c file.c", white() <> normal() <> "Prints the assembly code for this C file"},
              {green() <> bright() <> "ecc -p file.c", white() <> normal() <> "Compiles the optimized C file generating binary"},
              {green() <> bright() <> "ecc -ap file.c", white() <> normal() <> "Prints the optimized AST tree for this C file"},
              {green() <> bright() <> "ecc -cp file.c", white() <> normal() <> "Prints the optimized assembly code for this C file"},
              {green() <> bright() <> "ecc -o name file.c", white() <> normal() <> "Compiles C file changing executable name"},
              {green() <> bright() <> "ecc -op name file.c", white() <> normal() <> "Compiles optimized C file changing executable name"},
              {green() <> bright() <> "ecc -h", white() <> normal() <> "Prints this help\n\n"}]
        Enum.map(options, fn {command, description} -> IO.puts(white() <> "#{command} - #{description}") end)
    end

    def parse_error(parser_part) do
        parser_copy = parser_part
        case parser_copy do
            {:error, message} ->
                IO.puts(red() <> message)
            _ ->
                parser_copy
        end
    end

    def lex_error(lexer_part) do
        lexer_copy = lexer_part
        case lexer_copy do
            {:error, message} ->
                IO.puts(red() <> message)
            _ ->
                lexer_copy
        end
    end

    def out_path(file_path) do
        directories =  String.split(file_path, ~r{(\/)}, include_captures: false) #Detectamos si se indicaron carpetas al dar la ruta
        if length(directories) > 1 do #El usuario indicó carpetas, por lo que las respetamos
            String.replace_trailing(file_path, ".c", "")
        else #NO se indicaron carpetas, solo el nombre del ejecutable
            file_name = String.replace_trailing(file_path, ".c", "") #Nos encontramos en la carpeta del compilador, por lo que se indica esa carpeta
            String.replace_trailing(__ENV__.file, "lib/compiler.ex", file_name)
        end
    end

    def out_path(file_path, new_name) do
        directories = String.split(file_path, ~r{(\/)}, include_captures: false) #Detectamos si se indicaron carpetas al dar la ruta
        if length(directories) > 1 do #El usuario indicó carpetas, por lo que las respetamos
            String.replace_trailing(file_path, List.last(directories), new_name)
        else #NO se indicaron carpetas, solo el nombre del ejecutable
            String.replace_trailing(__ENV__.file, "lib/compiler.ex", new_name) #Nos encontramos en la carpeta del compilador, por lo que se indica esa carpeta
        end
    end
end
