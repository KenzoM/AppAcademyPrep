require 'byebug'

class Hangman
  MAX_GUESSES = 8
  attr_reader :guesser, :referee, :board, :num_remaining_guesses
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @num_remaining_guesses = MAX_GUESSES
  end

  def start_game
    prompt_players_intro
  end

  def prompt_players_intro
    if @referee.class == HumanPlayer
      puts "What is your name, referee?"
      @referee.get_name(gets.chomp)
    end
    if @guesser.class == HumanPlayer
      puts "What is your name, guesser?"
      @guesser.get_name(gets.chomp)
    end
    system('clear')
    puts "**************************"
    puts "Here are your players!!"
    puts "1: #{@referee.name} is the referee"
    puts "2: #{@guesser.name} is the guesser"
    puts "**************************"

    setup
    # until @board.all?{|x| x!= nil}
    while num_remaining_guesses != 0
      take_turn
      break if @board.all?{|x| x!= nil}
    end
    if @num_remaining_guesses == 0
      puts "\nSorry, you lost!"
      puts "the correct answer was #{referee.secret_word} "
    else
      puts "Congralutaion, you won!"
    end
  end

  def display_board
    display = ""
    @board.each do |x|
      if x.nil?
        display << "_"
      else
        display << x
      end
    end
    puts "Current board: #{display}"
  end

  def setup
    secret_length = @referee.pick_secret_word
    p "#{@referee.secret_word} is the secret word"
    guesser_length = @guesser.register_secret_length(secret_length) #this is where @candidate_words
    @board = Array.new(secret_length)
  end

  def take_turn
    display_board
    guesser_answer = @guesser.guess
    check_indeces = referee.check_guess(guesser_answer)
    update_board(guesser_answer, check_indeces)
    guesser.handle_response(guesser_answer, check_indeces)
    @num_remaining_guesses -= 1 if check_indeces.empty?
    puts "You have #{num_remaining_guesses} remaining guess left"
  end


  def update_board(guess_answer, indices)
    indices.each {|idx| @board[idx] = guess_answer}
  end

end

class HumanPlayer
  attr_reader :secret_word, :candidate_words, :name
  def initialize
    @dictionary = File.readlines("dictionary.txt")
  end

  def pick_secret_word
    puts "Pick a secret word (only length)"
    length = gets.chomp.to_i
  end
  def get_name(user_name)
    @name = user_name
  end

  def register_secret_length(secret_length)
    @candidate_words = @dictionary.select{|word| word.length == secret_length}
  end
  def guess
    puts "#{name}, what is your guess"
    answer = gets.chomp.downcase
    until (answer.length == 1) && (answer.is_a? String)
      puts "Invalid input! Please try again"
      answer = gets.chomp.downcase
    end
    answer
  end
  def check_guess
  end
  def handle_response(guess, response_indices)
    #no implementation needed
  end
end

class ComputerPlayer
  attr_reader :secret_word, :name
  attr_accessor :candidate_words
  def initialize(dictionary = nil)
    @dictionary = dictionary
    @name = "Albert, the Computer Machine"
  end

  def pick_secret_word
    if @dictionary.nil?
      random_word_pick.length
    else
      random_word_pick(@dictionary).length
    end
  end

  def random_word_pick(loaded_dictionary = File.readlines("dictionary.txt").sample)
    @secret_word = loaded_dictionary.delete!("\n") #<== removes newline from adding extra length
  end

  def check_guess(argument)
    correct_indeces = []
    secret_word.split(//).each_with_index do |letter, idx|
      correct_indeces << idx if argument == letter
    end
    correct_indeces
  end

  #~~~~~~~Phase II~~~~~~~!
  def register_secret_length(secret_length) ##Check this ..
    @candidate_words = @dictionary.select{|word| word.length == secret_length}
  end

  def guess(board)
    table = freq_table(board)
    letter = table.sort {|a,b| b[1]<=>a[1]}.first[0]
  end

  def freq_table(board)
    list_letters_table = Hash.new(0)
    board.each_with_index do |board_letter, idx|
      candidate_words.each do |word|
        list_letters_table[word[idx]] += 1 if board_letter.nil?
      end
    end
    list_letters_table
  end

  def handle_response(guess, response_indices)
    @candidate_words.reject! do |word| #recall that ! it modifies the original variable
      should_delete = false
      word.each_char.with_index do |letter, index|
        if (letter == guess) && (!response_indices.include?(index))
          should_delete = true
          break
        elsif (letter != guess) && (response_indices.include?(index))
          should_delete = true
          break
        end
      end
      should_delete
    end
  end

end

if $PROGRAM_NAME == __FILE__
  system('clear')
  puts "Let's play Hangman!"
  print "Referee: Computer (yes/no)? "
  if gets.chomp == "yes"
    referee = ComputerPlayer.new
  else
    referee = HumanPlayer.new
  end
  print "Guesser: Computer (yes/no)? "
  if gets.chomp == "yes"
    guesser = ComputerPlayer.new
  else
    guesser = HumanPlayer.new
  end
  Hangman.new({referee: referee, guesser: guesser}).start_game
end
