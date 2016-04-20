# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp/) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_reader :towers
  def initialize
    @towers = [[3,2,1],[],[]]
  end
  def play
    clear
    puts "We are going to play a little game.."
    puts "************************"
    until won?
      puts "Here are the towers"
      render
      puts "which tower do you wish to move from?"
      from = gets.chomp.to_i
      puts "which tower do you wish to move to?"
      final_destination = gets.chomp.to_i
      if valid_move?(from, final_destination)
        move(from, final_destination)
        puts "************************"
      else
        puts "************************"
        puts "Try again buddy!!"
        puts "************************"
      end
    end
  end
  def move(from_tower, to_tower)
    @towers[to_tower] << @towers[from_tower].pop
  end
  #
  def valid_move?(move_from, move_to)
    return false unless move_from.between?(0, 2) && move_to.between?(0, 2)
    #trick: moving to an empty tower is also acceptable!
      if !@towers[move_from].empty?
        if @towers[move_to].empty? || @towers[move_from].last < @towers[move_to].last
          return true
        else
          return false
        end
      else
        return false
      end
    end
  def won?
    @towers[0].empty? && @towers[1..2].any? {|x| x.empty?}
  end

  def render
    @towers.each_with_index do |tower,index|
      print "Tower #{index} :   #{tower}"
      puts
    end
  end
  def clear
    system('clear')
  end
end


if $PROGRAM_NAME == __FILE__ ##review this again!!
  TowersOfHanoi.new().play
end
