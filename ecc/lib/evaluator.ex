defmodule Evaluator do
  def evaluator_lexer(tokens) when tokens != [] do
    head= hd tokens
    tail= tl tokens
    if is_list(head) do
      head
    else
      evaluator_lexer(tail)
    end
  end

  def evaluator_lexer(tokens)  do
    []
  end
end