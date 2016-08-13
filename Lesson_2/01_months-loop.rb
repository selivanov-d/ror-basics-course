require_relative 'months'

$months.each do |month_name, days_in_month|
  puts month_name if days_in_month == 30
end
