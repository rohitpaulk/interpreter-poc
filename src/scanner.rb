class Scanner
  def initialize(source)
    @source = source
  end

  def scan_tokens
    @source.chars.each do |char|
      case char
      when "("
        Token.new(:left_paren, "(", nil, 1)
      when ")"
        Token.new(:right_paren, ")", nil, 1)
      when "{"
        Token.new(:left_brace, "{", nil, 1)
      when "}"
        Token.new(:right_brace, "}", nil, 1)
      else
        StandardError.new("Unknown character")
      end
    end
  end
end
