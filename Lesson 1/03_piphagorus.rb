triangle_sides = []

puts 'Чтобы выяснить является ли треугольник прямоугольным и равнобедренным, введите последовательно длины трёх его сторон:'
print 'первая стороная: '
triangle_sides << gets.chomp.to_i

print 'вторая стороная: '
triangle_sides << gets.chomp.to_i

print 'третья стороная: '
triangle_sides << gets.chomp.to_i

triangle_sides.each do |side|
  abort 'Все длины должны быть положительными числами!' if side <= 0
end

if triangle_sides.uniq.length == 1
  puts 'Треугольник равносторонний'
else
  hypotenuse = triangle_sides.sort!.pop

  if (triangle_sides[0]**2 + triangle_sides[1]**2) == hypotenuse**2
    puts 'Треугольник прямоугольный!'

    puts 'Треугольник равнобедренный!' if triangle_sides[0] == triangle_sides[1]
  else
    puts 'Очень странный треугольник. Может быть его вообще не может существовать. Одно можно сказать с уверенностью: он не прямоугольный.'
  end
end
