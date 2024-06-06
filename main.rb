require "bundler/setup"
require "zeitwerk"

loader = Zeitwerk::Loader.new
loader.push_dir("src")
loader.setup

if ARGV[0] != "tokenize"
  puts "Unknown command #{ARGV[0]}"
  exit(1)
end

source = File.read(ARGV[1])

Scanner.new(source).scan_tokens.each do |token_or_error|
  case token_or_error
  when Token
    puts token_or_error.debug_string
  else
    puts token_or_error
  end
end
