def tokenize(source)
  source.split(/\s+/)
end

if ARGV[0] != "tokenize"
  puts "Unknown command #{ARGV[0]}"
  exit(1)
end

source = File.read(ARGV[0])

source.chars.each do |char|
  case char
  when "("
    puts "LEFT_PAREN ( null"
  when ")"
    puts "RIGHT_PAREN ) null"
  else
    puts "Unknown char '#{char}'"
  end
end
