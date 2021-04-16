defmodule Sanitizer do

  def clean_source(file_content) do
   	trimmed_content = String.trim(file_content)
     	words =Regex.split(~r/\n/,trimmed_content)
     	count=0
   	do_list(words,count)
  end

  def do_list(program,linea) when program != []  do
      current_line=hd program
      remaining_lines=tl program
      token_list_no_num = Regex.split(~r/\s+/,current_line, trim: true)
      token_list_num = Enum.flat_map(token_list_no_num, fn x -> [{x,linea}] end)
      linea=linea+1
      remaining_list = do_list(remaining_lines,linea)
      token_list_num ++ remaining_list
  end

  def do_list(_program,_linea)  do
      []
  end
end
