triangle_sides = []

puts 'Чтобы выяснить является ли треугольник прямоугольным и равнобедренным, введите последовательно длины трёх его сторон:'
print 'первая стороная: '
triangle_sides << gets.chomp.to_f

print 'вторая стороная: '
triangle_sides << gets.chomp.to_f

print 'третья стороная: '
triangle_sides << gets.chomp.to_f

triangle_sides.each do |side|
  abort 'Все длины должны быть положительными числами!' unless side > 0
end

if triangle_sides.uniq.length == 1
  puts 'Треугольник равносторонний'
else
  triangle_sides.sort! # сортируем стороны по возрастанию, чтобы можно было выбрать гипотенузу (самую длинную сторону треугольника)

  hypotenuse = triangle_sides.pop
  catheti = triangle_sides

  if (catheti[0]**2 + catheti[1]**2) == hypotenuse**2
    puts 'Треугольник прямоугольный!'

    puts 'Треугольник равнобедренный!' if catheti[0] == catheti[1]
  else
    puts 'Очень странный треугольник. Может быть его вообще не может существовать. Одно можно сказать с уверенностью: он не прямоугольный.'
  end
end
