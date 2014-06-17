require 'yaml'

# Extensions for string class.
class String
  def anglicize
    split.map{|token| get_anglicized_word(token) }.join(" ")
  end

  def americanize
    split.map{|token| get_americanized_word(token) }.join(" ")
  end

  def has_alternate_english_spelling?
    self != anglicize
  end

  def has_alternate_american_spelling?
    self != americanize
  end

  def copy_case(word)
    if word == word.capitalize
      capitalize
    elsif word == word.upcase
      upcase
    else
      downcase
    end
  end

  private

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