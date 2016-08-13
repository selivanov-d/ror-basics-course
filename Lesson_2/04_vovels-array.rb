alphabet = ('a'..'z').to_a

vowels = %w(a e i o u y)

vowels_hash = {}

alphabet.each do |letter|
  if vowels.include? letter
    vowels_hash[letter] = alphabet.index(letter) + 1
  end
end

puts vowels_hash