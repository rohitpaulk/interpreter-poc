class Token
  attr_reader :type, :lexeme, :line_number

  def initialize(type, lexeme, literal, line_number)
    @type = type
    @lexeme = lexeme
    @literal = literal
    @line_number = line_number
  end

  def debug_string
    "#{@type.to_s.upcase} #{@lexeme} #{@literal || "null"} #{@line_number}"
  end
end
