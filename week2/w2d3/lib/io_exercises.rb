# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.

def guessing_game
  computer_number = rand(1..100)
  guesses = 0
  while true
    guesses += 1
    puts "guess a number"
    user_number = gets.chomp.to_i
    puts user_number
    #finish loop when the user's name and computer's number is same
    break if computer_number == user_number
    status = computer_number > user_number ? "low" : "high"
    puts "too #{status}"
  end
  puts "#{guesses}"
end

# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def shuffle_program(file)
  file_format = file.split(/\./) ##needs some refactoring here...
  file_name = file_format[0]
  file_ext = file_format[1]
  contents = File.readlines(file)
  shuffled_contents = contents.shuffle
  File.open("#{file_name}-shuffled.#{file_ext}", "w") do |f|
    shuffled_contents.each do |line|
      f.puts line
    end
  end
  kenzo_content = File.readlines("#{file_name}-shuffled.#{file_ext}")
  puts kenzo_content
end

if $PROGRAM_NAME == __FILE__
  #essentially we want to 2 options: one pre-loaded or other user's input_name
  #to load the file to be shuffled
  if ARGV[0]
    shuffle_program(ARGV[0])
  else
    puts "User, what file do you wish to shuffle?"
    file_name = gets.chomp
    shuffle_program(file_name)
  end
end
