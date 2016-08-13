require_relative 'months'

# Год високосный, если он делится на четыре без остатка, но если он делится на 100 без остатка, это не високосный год.
# Однако, если он делится без остатка на 400, это високосный год.
# Таким образом, 2000 г. является особым високосным годом, который бывает лишь раз в 400 лет.
def leap_year?(year)
  ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
end

def days_in_month(year, month_num)
  if month_num == 2
    leap_year?(year) ? 29 : 28
  else
    months_days_array = $months.values
    months_days_array[month_num - 1]
  end
end

days_to_date = 0

puts 'Вычисление порядкового номера дня в году по его дате.'
print 'год (число): '
year = gets.chomp.to_i

print 'месяц (число от 1 до 12): '
month = gets.chomp.to_i
abort 'Месяцев всего 12!' unless (1..12).include? month

print 'число (число от 1 до 31): '
day = gets.chomp.to_i

if day > days_in_month(year, month)
  abort 'В указанном месяце нет столько дней! Помните, в некоторых месяцах 31 день, в некоторых -- 30, а в феврале 28 или 29 дней в зависимости от года.'
end

if month > 1
  full_months = month - 1
  (1..full_months).to_a.each do |month_num|
    days_to_date += days_in_month(year, month_num)
  end
end

days_to_date += day

puts days_to_date
