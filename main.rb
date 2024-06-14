require "bundler/setup"
require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.push_dir("src")
loader.setup

case ARGV[0]
when "tokenize"
  source = File.read(ARGV[1])
  Scanner.new(source).scan_tokens.each do |token_or_error|
    puts token_or_error.is_a?(Token) ? token_or_error.debug_string : token_or_error
  end
when "parse"
  source = File.read(ARGV[1])
  tokens = Scanner.new(source).scan_tokens
  parser = Parser.new(tokens)
  ast = parser.parse
  puts AstPrinter.new.print(ast)
else
  puts "Unknown command #{ARGV[0]}"
  exit(1)
end
