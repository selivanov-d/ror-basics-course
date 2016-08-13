def get_item_total_price(item_props)
  item_props[:price] * item_props[:quantity]
end

purchases = {}
total_price = 0

puts 'Добро пожаловать в наш почти готовый интернет-магазин, убийцу Яндекс.Маркета'
puts 'Что хотите купить?'

while true
  print 'Название товара: '
  item_name = gets.chomp

  break if item_name == 'stop'

  print 'Количество единиц товара: '
  item_quantity = gets.chomp.to_f

  unless item_quantity > 0
    puts 'Количество товара должно быть больше нуля! Попробуйте ещё раз.'
    next
  end

  print 'Стоимость одной единицы товара: '
  item_price = gets.chomp.to_f
  unless item_price > 0
    puts 'Цена товара должна быть больше нуля. Вы, наверное, опечатались. Попробуйте ещё раз.'
    next
  end

  purchases[item_name] = {quantity: item_quantity, price: item_price}

  puts 'Может ещё что-то? Чтобы закончить добавление товаров и перейти к подсчёту итоговой стоимости покупок введите слово "stop".'
end

if purchases.size > 0
  puts purchases
  puts '-----'

  purchases.each do |item_name, item_props|
    item_total_price = get_item_total_price(item_props)
    total_price += item_total_price

    puts "Товар \"#{item_name}\" будет стоить #{item_total_price} рубл(ей|я|ь)"
  end

  puts '-----'
  puts "Итоговая сумма покупки: #{total_price} рубл(ей|я|ь)"
else
  puts 'В корзине пусто. :('
end
