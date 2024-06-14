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

  def next_char
    @source[@current_index + 1]
  end

  def scan_token
    char = consume_char!

    case char
    when "("
      add_token("LEFT_PAREN")
    when ")"
      add_token("RIGHT_PAREN")
    when "{"
      add_token("LEFT_BRACE")
    when "}"
      add_token("RIGHT_BRACE")
    when "!"
      if consume_char_if!("=")
        add_token("BANG_EQUAL")
      else
        add_token("BANG")
      end
    when "="
      if consume_char_if!("=")
        add_token("EQUAL_EQUAL")
      else
        add_token("EQUAL")
      end
    when "/"
      if consume_char_if!("/")
        until is_at_end? || consume_char!.eql?("\n")
          # consume comment until newline / EOF
        end
      else
        add_token("SLASH")
      end
    when " ", "\t", "\r", "\n"
      # ignore whitespace
    when '"'
      consume_string!
    when /\d/
      consume_number!
    else
      add_error("Unknown character '#{char.inspect}'")
    end
  end

  def consume_number!
    while current_char.match?(/[0-9]/)
      consume_char!
    end

    if current_char == "." && next_char.match?(/[0-9]/)
      consume_char!

      while current_char.match?(/[0-9]/)
        consume_char!
      end
    end

    add_token("NUMBER", literal: @source[@start_index...@current_index].to_f)
  end

  def consume_string!
    while consume_char_unless!('"') && !is_at_end?
      consume_char!
    end

    if consume_char_if!('"')
      add_token("STRING", literal: @source[@start_index + 1...@current_index - 1])
    else
      add_error("Unterminated string '#{@source[@start_index + 1...@current_index]}'")
    end
  end
end
