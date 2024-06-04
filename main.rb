if ARGV[0] != "tokenize"
  puts "Unknown command #{ARGV[0]}"
  exit(1)
end

source = File.read(ARGV[0])

Scanner.new(source).scan_tokens.each do |token_or_error|
  case token_or_error
  when Token
    puts token_or_error.debug_string
  else
    puts "Error: #{token_or_error}"
  end
end

source.chars.each do |char|
end
