puts 'Добро пожаловать в программу вычисления площади треугольника!'
puts 'Каково основание треугольника?'
triangle_base = gets.chomp.to_f
abort 'Основание треугольника дожно быть положительным числом!' unless triangle_base > 0

puts 'Какова высота треугольника?'
triangle_height = gets.chomp.to_f
abort 'Высота треугольника дожна быть положительным числом!' unless triangle_height > 0

triangle_area = 0.5 * triangle_base * triangle_height

puts "Площать треугольника равна #{triangle_area}"
