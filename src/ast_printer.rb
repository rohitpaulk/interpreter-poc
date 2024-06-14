class AstPrinter
  def print(expression)
    expression.accept(self)
  end

  # def visit_binary_expression(expression)
  #   parenthesize(expression.operator, expression.left, expression.right)
  # end

  def visit_literal_expression(expression)
    if expression.value.nil?
      "nil"
    elsif expression.value.is_a?(String)
      "\"#{expression.value}\""
    else # Number
      expression.value.to_s
    end
  end

  def visit_unary_expression(expression)
    parenthesize(expression.operator, expression.right)
  end

  # def visit_grouping_expression(expression)
  #   parenthesize("group", expression.expression)
  # end

  protected

  def parenthesize(name, *expressions)
    "(#{name} #{expressions.map { |expression| expression.accept(self) }.join(" ")})"
  end
end
