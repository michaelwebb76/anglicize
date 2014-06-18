require 'yaml'

# Extensions for string class.
class String
  def anglicize
    result = self.dup
    scan(WORD_RE).uniq.each do |word|
      result.gsub!(/\b#{word}\b/, get_anglicized_word(word))
    end
    result
  end

  def anglicize!
    self.replace(self.anglicize)
  end

  def americanize
    result = self.dup
    scan(WORD_RE).uniq.each do |word|
      result.gsub!(/\b#{word}\b/, get_americanized_word(word))
    end
    result
  end

  def americanize!
    self.replace(self.americanize)
  end

  def has_alternate_english_spelling?
    self != anglicize
  end

  def has_alternate_american_spelling?
    self != americanize
  end

  def copy_case(word)
    result = ""
    if word.upcase == word
      result = self.upcase
    elsif word.downcase == word
      result = self.downcase
    else
      self.chars.each_with_index do |char, index|
        word_char = word[index] || "a"
        result << (word_char.upcase == word_char ? char.upcase : char.downcase)
      end
    end
    result
  end

  private

  WORD_RE = /\b[a-zA-Z]+\b/

  def get_anglicized_word(word)
    @@american_to_english ||= load_american_to_english
    key = word.downcase
    (@@american_to_english[key] || word).copy_case(word)
  end

  def get_americanized_word(word)
    @@english_to_american ||= load_english_to_american
    key = word.downcase
    (@@english_to_american[key] || word).copy_case(word)
  end

  def load_american_to_english
    @@alternate_spellings ||= load_alternate_spellings
    @@alternate_spellings.invert
  end

  def load_english_to_american
    @@alternate_spellings ||= load_alternate_spellings
  end

  def load_alternate_spellings
    dirname = File.dirname(File.expand_path(__FILE__))
    file_path = File.join(dirname, "alternate_spellings.yml")
    YAML::load(File.open(file_path))
  end
end