module Expressions
  class Base
    # Call Visitor#visit_binary_expression for Expressions::Binary, Visitor#visit_unary_expression for Expressions::Unary, etc.
    def accept(visitor)
      visitor.send(:"visit_#{self.class.name.split("::").last.downcase}_expression", self)
    end
  end

  class Binary < Base
    attr_reader :left, :operator, :right

    # @param [Expressions::Base] left
    # @param [String] operator
    # @param [Expressions::Base] right
    def initialize(left, operator, right)
      @left = left
      @operator = operator
      @right = right
    end
  end

  class Grouping < Base
    attr_reader :expression

    # @param [Expressions::Base] expression
    def initialize(expression)
      @expression = expression
    end
  end

  class Literal < Base
    attr_reader :value

    # @param [Object] value
    def initialize(value)
      @value = value
    end
  end

  class Unary < Base
    attr_reader :operator, :right

    # @param [Token] operator
    # @param [Expressions::Base] right
    def initialize(operator, right)
      @operator = operator
      @right = right
    end
  end
end
