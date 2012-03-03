
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
  string.downcase.scan(/\b(\w+)\b/).each do |key|
    if count.has_key?(key)
      count[key] += 1
    else
      count[key] = 1
    end
  end
  
  return count
end


# Tests

# palindrome?("A man, a plan, a canal -- Panama") # => true
# palindrome?("Madam, I'm Adam!") #=> true
# palindrome?("Abracadabra") #=> false

# puts palindrome?("A man, a plan, a canal -- Panama")
# puts palindrome?("Madam, I'm Adam!")
# puts palindrome?("Abracadabra")


# puts count_words "Doo bee doo bee doo"


