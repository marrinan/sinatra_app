# pig_latin.rb

class String
  def translate
    word = self
    first_vowel_hit = false
    word.each_char do |char|
      if "aeiou".include?(char) || first_vowel_hit
        first_vowel_hit = true
        next
      else
        if word[0..1] == "qu"
          word = word[2..-1] + word[0..1]
        else
          word = word[1..-1] + word[0]
        end
      end
    end
    word + "ay"
  end
end