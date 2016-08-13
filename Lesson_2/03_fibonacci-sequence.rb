@res = []

def fibonacci_sequence(stop = 1000)
  options = {current_number: 1, last_number: 0, stop: stop}

  @res << get_next_fibonacci_number(options[:current_number], options[:last_number], options[:stop])
end

def get_next_fibonacci_number(current_number, last_number, stop)
  next_number = current_number + last_number

  @res << current_number

  get_next_fibonacci_number(next_number, current_number, stop) if next_number < stop
end

puts fibonacci_sequence(100)
