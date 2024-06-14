class Parser
  attr_accessor :tokens_or_errors

  def initialize(tokens)
    @tokens = tokens
    @current_index = 0
  end

  protected

  def expression_rule
    equality_rule
  end

  def equality_rule
    expression = primary_rule # TODO: Change to comparison_rule later

    while match!(:bang_equal, :equal_equal)
      operator = previous # TODO: What happens if there is no previous token?
      right = comparison_rule
      expression = Expression::Binary.new(expression, operator, right)
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
    if match!(:nil)
      Expressions::Literal.new(nil)
    elsif match!(:number, :string)
      Expressions::Literal.new(previous.literal)
    else
      raise "Unexpected token: #{previous.type}"
    end
  end

  def at_end?
    peek.type == :EOF
  end

  def peek
    @tokens[@current_index]
  end

  def previous
    @tokens[@current_index - 1]
  end
end
