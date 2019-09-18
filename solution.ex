# Find index of closing paren in string for the open paren pointed at by the given index
defmodule Solution do
  def solution(parentheses, index) do
    graphemes = String.graphemes(parentheses)

    if index > length(graphemes) - 1 or Enum.at(graphemes, index) != "(" do
      raise "Index out of bounds!"
    else
      graphemes
      |> Enum.slice(index..-1)
      |> Enum.with_index()
      |> find_closing_paren()
    end
  end

  def find_closing_paren(graphemes_with_index) do
    {_, _, closing_index} =
      Enum.reduce(graphemes_with_index, {0, 0, 0}, fn
        {_, index}, {open_paren_count, close_paren_count, _close_paren_index}
        when open_paren_count == close_paren_count and open_paren_count != 0 and
               close_paren_count != 0 ->
          {open_paren_count, close_paren_count, index}

        {"(", _}, {open_paren_count, close_paren_count, close_paren_index} ->
          {open_paren_count + 1, close_paren_count, close_paren_index}

        {")", _}, {open_paren_count, close_paren_count, close_paren_index} ->
          {open_paren_count, close_paren_count + 1, close_paren_index}

        {_, _}, accumulator ->
          accumulator
      end)

    closing_index
  end
end

Solution.solution("()", 0)
Solution.solution("()", 1)
Solution.solution("()", 2)
Solution.solution("(())", 1)
Solution.solution("(((()(((()))))))", 1)
Solution.solution("(((()(((()))))))", 2)
Solution.solution("(((()(((()))))))", 0)
Solution.solution("(((()(((()))))))", 5)

# Given a string, s, find the length of the longest substring that contains no repeated characters.
# Example input
# s: "nndfddf"
# Example Output:
# 3

# Explanation:
# "ndf" is the longest substring within "nndfddf" that contains no repeated characters, and its
# length is 3 characters.

defmodule Solution do
  @doc "longest non repeating substring length."
  def solution(s) do
    String.graphemes(s)
    |> find_longest_possible_non_repeating_substring(0)
  end

  def find_longest_possible_non_repeating_substring([], substring_length), do: substring_length

  def find_longest_possible_non_repeating_substring(
        graphemes = [first_grapheme | rest],
        current_longest_sub_string
      ) do
    {_, substring_length, _} =
      Enum.reduce(rest, {[first_grapheme], 1, "CONT"}, fn
        grapheme, {chars_that_cant_repeat, length_of_substring, "HALT"} ->
          {chars_that_cant_repeat, length_of_substring, "HALT"}

        grapheme, {chars_that_cant_repeat, length_of_substring, "CONT"} ->
          if grapheme in chars_that_cant_repeat do
            {chars_that_cant_repeat, length_of_substring, "HALT"}
          else
            {[grapheme | chars_that_cant_repeat], length_of_substring + 1, "CONT"}
          end
      end)

    if substring_length > current_longest_sub_string do
      find_longest_possible_non_repeating_substring(rest, substring_length)
    else
      find_longest_possible_non_repeating_substring(rest, current_longest_sub_string)
    end
  end
end

Solution.solution("abcabc")
Solution.solution("aa")
Solution.solution("abbcabc")
Solution.solution("abcdef")
Solution.solution("aaaaaaaaabbbbbbbbbbbbaaaaaaaaaaabbbbbbbbbbbbb")
