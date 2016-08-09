puts 'Добро пожаловать в программу вычисления площади треугольника!'
puts 'Каково основание треугольника?'
triangle_base = gets.chomp.to_i
abort 'Основание треугольника дожно быть положительным числом!' if triangle_base <= 0

puts 'Какова высота треугольника?'
triangle_height = gets.chomp.to_i
abort 'Высота треугольника дожна быть положительным числом!' if triangle_height <= 0

triangle_area = 0.5 * triangle_base * triangle_height

puts "Площать треугольника равна #{triangle_area}"
