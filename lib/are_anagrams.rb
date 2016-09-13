module AreAnagrams
  def self.are_anagram?(string_a, string_b)
    return false unless string_a.size == string_b.size
    counts = string_a.downcase.each_char.with_object(Hash.new(0)) { |c,h| h[c] += 1 }
    string_b.downcase.each_char do |c|
      return false unless counts[c] > 0
      counts[c] -= 1
    end
    true
  end
end
