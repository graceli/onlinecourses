def palindrome?(string)
	# ignore case, punctuation, and nonword characters
	# set all letters in the string to lower case
	# reverse the string
	# return true if two strings are equal otherwise false

	word_string = string.gsub(/\W/, '').downcase
  return word_string == word_string.reverse
end

def count_words(string)
  count = Hash.new(0)
  string.scan(/\b\w+\b/).each do |key|
    count[key.downcase] += 1
  end
  
  return count
end

# result = count_words "To be, or not to be, that is the question:\nWhether 'tis Nobler in the mind to suffer\nThe Slings and Arrows of outrageous Fortune,\nOr to take Arms against a Sea of troubles,\nAnd by opposing end them: to die, to sleep\nNo more; and by a sleep, to say we end\nThe heart-ache, and the thousand Natural shocks\nThat Flesh is heir to? 'Tis a consummation\nDevoutly to be wished. To die to sleep,\nTo sleep, perchance to Dream; Ay, there's the rub,\nFor in that sleep of death, what dreams may come,\nWhen we have shuffled off this mortal coil,\nMust give us pause."
# 
# p result
# 
# expected = {"to"=>13, "be"=>3, "or"=>2, "not"=>1, "that"=>3, "is"=>2, "the"=>6, "question"=>1, "whether"=>1, "tis"=>2, "nobler"=>1, "in"=>2, "mind"=>1, "suffer"=>1, "slings"=>1, "and"=>4, "arrows"=>1, "of"=>3, "outrageous"=>1, "fortune"=>1, "take"=>1, "arms"=>1, "against"=>1, "a"=>3, "sea"=>1, "troubles"=>1, "by"=>2, "opposing"=>1, "end"=>2, "them"=>1, "die"=>2, "sleep"=>5, "no"=>1, "more"=>1, "say"=>1, "we"=>2, "heart"=>1, "ache"=>1, "thousand"=>1, "natural"=>1, "shocks"=>1, "flesh"=>1, "heir"=>1, "consummation"=>1, "devoutly"=>1, "wished"=>1, "perchance"=>1, "dream"=>1, "ay"=>1, "there"=>1, "s"=>1, "rub"=>1, "for"=>1, "death"=>1, "what"=>1, "dreams"=>1, "may"=>1, "come"=>1, "when"=>1, "have"=>1, "shuffled"=>1, "off"=>1, "this"=>1, "mortal"=>1, "coil"=>1, "must"=>1, "give"=>1, "us"=>1, "pause"=>1}
# 
# if result == expected
#   p "Passed"
# else
#   p "Failed"
# end


