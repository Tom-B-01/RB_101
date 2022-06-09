# Greet the user
# Get loan amount in dollars and verify input
# Get APR as XX.XX% and verify input
# Get loan duration in years and verify input

# Calculate monthly rate and loan duration
# Calculate monthly payment
# Print monthly payment
# Ask to repeat or end
require "yaml"
MESSAGES = YAML.load_file("loan_calculator_message.yml")

def verify_number(user_string)
  /^\d*\.?\d*$/.match(user_string)
end

def calculate_monthly(principle, annual_rate, annual_duration)
  monthly_interest_rate = annual_rate.to_f / 12.0 / 100.0
  monthly_duration = annual_duration.to_f * 12.0
  monthly_payment = principle.to_f * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-monthly_duration)))
  monthly_payment = ((monthly_payment * 100).to_i.to_f) / 100.0 # this is kind of unnecessary, but it makes the output look better
  monthly_payment
end

name = nil
loan_amount = ""
annual_interest_rate = ""
loan_duration = ""
# Full Program Loop
loop do
  # Welcome and Name entry loop
  Kernel.puts(MESSAGES['welcome'])
  loop do
    name = Kernel.gets().chomp()
    if !name.nil?
      break
    else
      Kernel.puts(MESSAGES['invalid_name'])
    end
  end
  # Loan Principle loop
  Kernel.puts(MESSAGES['amount_prompt'])
  loop do
    loan_amount = Kernel.gets().chomp()
    if verify_number(loan_amount)
      break
    else
      Kernel.puts(MESSAGES['invalid_amount'])
    end
  end
  # Loan APR Loop
  Kernel.puts(MESSAGES['apr_prompt'])
  loop do
    annual_interest_rate = Kernel.gets().chomp()
    if verify_number(annual_interest_rate)
      break
    else
      Kernel.puts(MESSAGES['invalid_apr'])
    end
  end
  # Loan Duration loop
  Kernel.puts(MESSAGES['duration_prompt'])
  loop do
    loan_duration = Kernel.gets().chomp()
    if verify_number(loan_duration)
      break
    else
      Kernel.puts(MESSAGES['invalid_duration'])
    end
  end
  # Get monthly payment
  monthly_payment = calculate_monthly(loan_amount, annual_interest_rate, loan_duration)
  Kernel.puts(MESSAGES['calculating'])
  Kernel.puts(MESSAGES['payment'] + "$" + monthly_payment.to_s)

  Kernel.puts(MESSAGES['again'])
  repeat = Kernel.gets().chomp().downcase()
  break if repeat == "no" || repeat == 'n'
end

Kernel.puts(MESSAGES['thank_you'])
