# Get two numbers from the user.
# Get the type of calculation from user.
# perform that operation on the two numbers.
# print the results.
require "pry"

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  (number.to_i != 0 || number == "0")
end

def number?(number)
  number.chars().each({|char| char.to_i.to_s == char || char = "."})
end

def operation_to_message(o_string)
  case o_string
  when 'add'
    "Adding"
  when 'subtract'
    "Subtracting"
  when 'multiply'
    'Multiplying'
  when 'divide'
    "Dividing"
  end
end

prompt("Welcome to the calculator! Enter your name:")
name = ""
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Make sure to enter your name")
  else
    break
  end
end

prompt("Hi, #{name}!")

binding.pry
# Main loop
loop do
  number1 = ''
  loop do
    prompt("Please enter a number")
    number1 = Kernel.gets().chomp()
    # puts number1

    if valid_number?(number1)
      break
    else
      prompt("Please give a valid input")
    end
  end

  number2 = ''
  loop do
    prompt("Please enter another number")
    number2 = Kernel.gets().chomp()
    # puts number2

    if valid_number?(number2)
      break
    else
      prompt("Please give a valid input")
    end
  end

  prompt("What operation would you like to perform? \n
          (add, subtract, multiply, divide)")
  operation_string = ''
  loop do
    operation_string = Kernel.gets().chomp()
    if %w(add subtract multiply divide).include?(operation_string)
      break
    else
      prompt("Please enter one of the operators")
    end
  end

  prompt("#{operation_to_message(operation_string)} the two numbers...")

  result = case operation_string
           when 'add'
             number1.to_i + number2.to_i
           when 'subtract'
             number1.to_i - number2.to_i
           when 'multiply'
             number1.to_i * number2.to_i
           when 'divide'
             number1.to_f / number2.to_f
           end

  prompt("Your result is #{result}")

  prompt("Do you want to perform another calculation? (Enter 'y' to run again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using this calculator!")
