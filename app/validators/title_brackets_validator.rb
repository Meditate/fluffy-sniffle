class TitleBracketsValidator < ActiveModel::Validator
  PAIRS = {
    "[" => "]",
    "(" => ")",
    "{" => "}"
  }.freeze
  OPENERS = PAIRS.keys.freeze
  CLOSERS = PAIRS.values.freeze

  def validate(record)
    if empty_brackets?(record.title) ||
        odd_brackets?(record.title) ||
        single_brackets?(record.title)
      record.errors.add(:title, "has invalid title")
    end
  end

  private

  def empty_brackets?(title)
    title.match? /\(\)|\[\]|\{\}/
  end

  def single_brackets?(title)
    brackets_stack = title.scan /[\(\)\[\]\{\}]/
    loop do
      return if brackets_stack.blank?
      brackets_stack.each_with_object("") do |curr_bracket, curr_opener|
        if OPENERS.include?(curr_bracket)
          curr_opener.replace(curr_bracket)
        elsif CLOSERS.include?(curr_bracket) && PAIRS[curr_opener] == curr_bracket
          brackets_stack.delete_at(brackets_stack[0..brackets_stack.index(curr_bracket)].rindex(curr_opener))
          brackets_stack.delete_at(brackets_stack.index(curr_bracket))
          curr_opener.clear
          break
        else
          return true
        end
      end
    end
  end

  def odd_brackets?(title)
    brackets_stack = title.scan /[\(\)\[\]\{\}]/
    return true if brackets_stack.present? && brackets_stack.size % 2 != 0
  end
end
