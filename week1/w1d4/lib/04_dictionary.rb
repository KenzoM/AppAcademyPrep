class Dictionary
  attr_reader :entries
  def initialize
    @entries = {}
  end
  def add(new_entries)
    if new_entries.class == String
      hash_without_value = {new_entries => nil}
      @entries.merge!(hash_without_value)
    else
      @entries.merge!(new_entries) #<+ important to use ! to modify the original variable
    end
  end
  def keywords
    @entries.keys.sort { |x, y| x <=> y }
  end

  def include?(key)
    @entries.has_key?(key)
  end

  def find(word)
    matched = {}
    @entries.each do |key,value|
      if key.include?(word)
        matched[key] = value
      end
    end
    matched
  end

  def printable #printable output like so: [keyword] 'definition'"
      answer = ""
      @entries.sort.each do |key,value|
          answer << "[#{key}] \"#{value}\"\n"
      end
      answer.strip
  end
end
