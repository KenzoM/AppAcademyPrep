def echo(string)
    string
end

def shout(string)
    string.upcase
end

def repeat(*phrase) #messed around with splat opeator..works as well
    string = phrase[0]
    repetition = phrase[1]
    repetition = 2 if phrase[1] == nil
    ((string + " ") * repetition).strip
end

def start_of_word(string,index)
    string[0..index - 1]
end

def first_word(string)
    words = string.split(" ")
    words.first
end

def titleize(string)
    words = string.split(" ")
    little_words = ["the", "and", "over","an","a"]
    # answer = []
    # words.each_with_index do |word,index|
    #     if little_words.include?(word)
    #         if index == 0
    #             answer << word[0].upcase + word[1..-1]
    #         else
    #             answer << word
    #         end
    #     else
    #         answer << word[0].upcase + word[1..-1]
    #     end
    # end
    answer = words.map.with_index do |word,index| #REFACTORED!
        if little_words.include?(word) && index != 0
          word.downcase
        else
          word.capitalize #was not aware #capitalize method existed
        end
    end
    answer.join(" ")
end
