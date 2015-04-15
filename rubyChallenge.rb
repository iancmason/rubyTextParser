#Ruby Challenge file by Ian Mason
#April 14, 2015

require 'json'

class String
  def palindrome?
    letters = self.downcase.scan(/\w/)
    letters == letters.reverse
  end
end


tempHash = {
    "characters" => "val_a",
    "special_characters" => "val_b",
    "sum" => "val_c",
    "palindromes" => "val_d"
}

text=File.open('text.txt').read
text.gsub!(/\r\n?/, "\n")

#count total number of characters
totalCharacters = text.gsub(/\s+/, '').length
tempHash["characters"] = totalCharacters

#count total number of special characters
specialCharacters = text.gsub(/[0-9A-Za-z\s+]/, '').length
tempHash["special_characters"] = specialCharacters

#sum integers in file
numbersInText = text.gsub(/[^\d]/, '').split(//)
newSum = numbersInText.map(&:to_i)
sumInText = 0
newSum.each do |a|
  sumInText += a
end
tempHash["sum"] = sumInText

#find palindromes in text
arrayText = []
palArray = []

text.each_line do |line|
  arrayText = line.split
end

#find words that are palindromes
arrayText.each do |item|
   if item.palindrome? == true
      palArray.push(item)
    end
end

#find phrases that are palindromes
counter = 1
arrayText.each do |item|
  phrase = item + " " + arrayText[counter].to_s
  if (phrase).palindrome? == true
      palArray.push(phrase)
    end
    counter+=1
  end

palArray.map!(&:downcase)
palindromeArray = palArray.uniq

tempHash["palindromes"] = palindromeArray

File.write('output.json', tempHash.to_json)
