# Game Loop
class Mastermind
  def initialize
    @word_bank = %w[Red Blue Green Yellow Purple Orange Pink Brown Turquoise Lavender Indigo Cyan Maroon Olive Coral
                    Silver Gray Teal Gold Magenta]
    @turns = 12
    @current_word_index = 0
  end

  def generate_secret
    @secret = @word_bank.sample.to_s.downcase
  end

  def player_generate_secret
    puts 'Assign a color for the computer to predict.'
    @secret = gets.chomp.to_s.downcase
  end

  def player_guess
    @guess = gets.chomp.to_s.downcase
  end

  def correct_letter_count
    correct_count = 0

    @secret.chars.each_with_index do |char, index|
      correct_count += 1 if char == @guess[index]
    end
    correct_count
  end

  def generate_computer_guess
    current_word = @word_bank[@current_word_index]
    if current_word.nil?
      puts 'Error: No more words in the word bank.'
      return
    end
    guess = initial_guess(current_word.length)
    loop do
      feedback = get_feedback(guess)
      break if feedback == current_word
      prune_word_bank(guess, feedback)
      guess = refine_guess(guess, feedback)
    end
    @current_word_index += 1
    guess
  end
  def initial_guess(length)
    ('a'..'z').to_a.sample(length).join('')
  end

  def get_feedback(guess)
    puts "Computer's guess: #{guess}"
    puts 'Enter feedback (e.g., "correct positions, correct letters"):'
    gets.chomp.downcase
  end

  def prune_word_bank(guess, feedback)
    @word_bank.reject! { |word| feedback(word, guess) != feedback }
  end

  def refine_guess(previous_guess, feedback)
    # Here, you can implement a more sophisticated algorithm for refining the guess
    # For simplicity, let's just generate a random guess with the same length
    ('a'..'z').to_a.sample(previous_guess.length).join('')
  end

  def feedback(word, guess)
    word.chars.zip(guess.chars).count { |w, g| w == g }.to_s + ', ' +
      word.chars.uniq.count { |c| guess.include?(c) && word.count(c) == guess.count(c) }.to_s
  end

  def computer_game
    loop do
      player_generate_secret
      @current_word_index = 0  # Reset index for a new game
      @turns = 12  # Reset turns for a new game  
      loop do
        @guess = generate_computer_guess
        if @guess == @secret
          puts 'The Computer Has Won'
          puts "#{@guess}"
          break
        end
        @turns -= 1
        if @turns.zero?
          puts 'The Computer Has Run Out Of Turns'
          puts "Secret was: #{@secret}"
          break
        end
      end
      puts 'Do you want to play again? (yes/no)'
      play_again = gets.chomp.downcase
      break if play_again != 'yes'
    end
  end

  def player_game
    generate_secret
    loop do
      player_guess
      if @secret == @guess
        puts 'The Guess is Correct!'
        break
      end

      @turns -= 1
      correct_count = correct_letter_count
      puts "You Got It Wrong, turns left #{@turns}, #{correct_count} of letters correct"

      if @turns.zero?
        puts "Game over. The secret was #{@secret}"
        break
      end
    end
  end
end

# Example usage
game = Mastermind.new
game.computer_game

