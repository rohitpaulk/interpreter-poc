class Scanner
  attr_accessor :tokens_or_errors

  def initialize(source)
    @source = source
    @start_index = 0
    @current_index = 0
    @line_number = 1
    @tokens_or_errors = []
  end

  def has_errors?
    @tokens_or_errors.any? { |token_or_error| token_or_error.is_a?(StandardError) }
  end

  def is_at_end?
    @current_index >= @source.length
  end

  def scan_tokens
    until is_at_end?
      @start_index = @current_index
      scan_token
    end

    tokens_or_errors
  end

  private

  def add_token(type, literal: nil)
    tokens_or_errors << Token.new(type, @source[@start_index...@current_index], literal, @line_number)
  end

  def add_error(message)
    tokens_or_errors << StandardError.new("[line #{@line_number}] Error: #{message}")
  end

  def consume_char!
    current_char.tap do |char|
      @current_index += 1
      @line_number += 1 if char == "\n"
    end
  end

  def consume_char_if!(char)
    if current_char == char
      consume_char!
    else
      false
    end
  end

  def consume_char_unless!(char)
    if current_char == char
      false
    else
      consume_char!
    end
  end

  def current_char
    @source[@current_index]
  end

  def scan_token
    char = consume_char!

    case char
    when "("
      add_token(:left_paren)
    when ")"
      add_token(:right_paren)
    when "{"
      add_token(:left_brace)
    when "}"
      add_token(:right_brace)
    when "!"
      if consume_char_if!("=")
        add_token(:bang_equal)
      else
        add_token(:bang)
      end
    when "="
      if consume_char_if!("=")
        add_token(:equal_equal)
      else
        add_token(:equal)
      end
    when "/"
      if consume_char_if!("/")
        until is_at_end? || consume_char!.eql?("\n")
          # consume comment until newline / EOF
        end
      else
        add_token(:slash)
      end
    when " ", "\t", "\r", "\n"
      # ignore whitespace
    when '"'
      consume_string!
    else
      add_error("Unknown character '#{char.inspect}'")
    end
  end

  def consume_string!
    while consume_char_unless!('"') && !is_at_end?
      consume_char!
    end

    if consume_char_if!('"')
      add_token(:string, literal: @source[@start_index + 1...@current_index - 1])
    else
      add_error("Unterminated string '#{@source[@start_index+1...@current_index]}'")
    end
  end
end
