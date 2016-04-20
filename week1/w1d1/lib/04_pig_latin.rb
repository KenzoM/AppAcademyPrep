def translate(string)
    words = string.split(" ")
    vowels = ['a','i','u','e','o']
    answer = []
    words.each do |word|
        index = 0
        while true
            if vowels.include?(word[index].downcase)
                if word[-1] == 'q'
                    word = convert(word)
                else
                    if vowels.include?(word[index]) #checks if the letters are
                                                    #upper case or not
                      word = word + "ay"
                    else
                      word = word + "AY"
                    end
                    break
                end
            else
                word = convert(word)
            end
        end
        answer << word
    end
    answer.join(" ")
end

def convert(string) #the purpose of this is to move the appropiate letters to the end of the word
    letters = string.split(//)
    first_letter = letters.shift
    letters.push(first_letter)
    letters.join("")
end
