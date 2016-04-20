class Book
  attr_accessor :title
  def initialize
  end
  def title
    answer = []
    little_words = ["the", "and", "over", "an", "in", "of", "a"]
    words = @title.split(" ")
    words.each_with_index do |word,index|
      if little_words.include?(word) && index != 0
        answer << word
      else
        word = word[0].upcase + word[1..-1] #you can use #capitulize instead
        answer << word
      end
    end
    @title = answer.join(" ")
  end
end
