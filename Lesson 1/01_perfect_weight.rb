puts 'Хочешь узнать свой идеальный вес? Я помогу тебе в этом. Но сначала, давай познакомимся.'

puts 'Итак, как тебя зовут?'
name = gets.chomp

puts "Очень приятно, #{name}! А какой у тебя рост в сантиметрах?"
height = gets.chomp.to_i
abort 'Рост должен быть целым положительным числом!' if height <= 0

puts 'Ага. А теперь нескромный вопрос: сколько ты весишь в килограммах?'
actual_weight = gets.chomp.to_i
abort 'Вес должен быть целым положительным числом!' if actual_weight <= 0

perfect_weight = height - 110

if actual_weight > perfect_weight
  puts "Твой идеальный вес #{perfect_weight}. Надо бы тебе похудеть, #{name}!"
else
  puts "Поздравляю, #{name}! Твой вес уже идеален!"
end
