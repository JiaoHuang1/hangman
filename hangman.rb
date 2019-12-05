class Hangman
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word 
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    false
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index {|ele, i| indices << i if ele == char}
    indices
  end

  def fill_indices(char, indices)
    indices.each {|idx| @guess_word[idx] = char}
  end

  def try_guess(char)
    if self.already_attempted?(char)
      print "that has already been attempted"
      return false
    else  
      @attempted_chars << char
      indices = self.get_matching_indices(char)
      if indices.empty?
        @remaining_incorrect_guesses -= 1
      else  
        fill_indices(char, indices)
      end
      return true
    end
  end

  def ask_user_for_guess
    print 'Enter a char:'
    char = gets.chomp
    self.try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true 
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    false
  end

  def game_over?
    if win? || lose?
      puts "The secret word is: #{@secret_word}"
      return true
    end
    false
  end
  

end
