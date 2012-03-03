def palindrome?(string)
	# ignore case, punctuation, and nonword characters
	# set all letters in the string to lower case
	# reverse the string
	# return true if two strings are equal otherwise false

	word_string = string.gsub(/\W/, '').downcase
  return word_string == word_string.reverse
end

def count_words(string)
  count = {}
  string.gsub(/\W/, ' ').downcase.scan(/\b(\w+)\b/).each do |key|
    if count[key].nil?
      count[key] = 1
    else
      count[key] += 1
    end
  end
  
  return count
end



