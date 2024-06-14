class Parser
  class ParseError < StandardError; end

  attr_accessor :tokens_or_errors

  def initialize(tokens)
    @tokens = tokens
    @current_index = 0
  end

  def parse
    expression_rule
  rescue ParseError
    nil
  end

  protected

  def advance!
    @current_index += 1 unless at_end?
    previous_token
  end

  def expression_rule
    equality_rule
  end

  def equality_rule
    expression = primary_rule # TODO: Change to comparison_rule later

    while match!("EQUAL_EQUAL", "BANG_EQUAL")
      operator = previous_token # TODO: What happens if there is no previous token?
      right = primary_rule # TODO: Change to compression_rule later
      expression = Expressions::Binary.new(expression, operator, right)
    end

    expression
  end

  def check(token_type)
    @tokens[@current_index].type == token_type
  end

  def match!(*token_types)
    token_types.each do |token_type|
      if check(token_type)
        advance!
        return true
      end
    end

    false
  end

  def primary_rule
    if match!("NIL")
      Expressions::Literal.new(nil)
    elsif match!("NUMBER", "STRING")
      Expressions::Literal.new(previous_token.literal)
    else
      raise "Unexpected token: #{previous_token.type}"
    end
  end

  def at_end?
    peek.type == "EOF"
  end

  def peek
    @tokens[@current_index]
  end

  def previous_token
    @tokens[@current_index - 1]
  end
end
