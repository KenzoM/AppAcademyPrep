#!/usr/bin/env ruby

require_relative "12_rpn_calculator"
class RPNCalculator
  def self.user_prompt
    input = ""
    puts "What would you like to do? Please input number and operator"
    puts "Press ENTER to execute when finished"
    loop do
      user_input = gets.chomp
      break if user_input.empty?
      input << user_input + " "
    end
    self.caluculate_it(input)
  end

  def self.caluculate_it(input)
    puts "Your calculation:"
    calculculation = RPNCalculator.new
    puts "[#{input.strip}] = #{calculculation.evaluate(input)}"
  end

  def self.file_prompt(file)
    contents = File.readlines(file)
    contents.each do |input|
      self.caluculate_it(input)
    end
  end
end


if $PROGRAM_NAME == __FILE__
  if ARGV[0] #if file already exit..
    RPNCalculator.file_prompt(ARGV[0])
  else
    RPNCalculator.user_prompt
  end
end
