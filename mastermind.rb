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
    letter_to_guess = current_word[@turns]

    if letter_to_guess.nil?
      @current_word_index += 1
      return generate_computer_guess if @current_word_index < @word_bank.length
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
        puts "game over the secret was #{@secret}"
        break
      end
    end
  end

  def computer_game
    player_generate_secret
    loop do
      if @guess == generate_computer_guess
        puts 'The Computer Has Won'
        break
      end
      if @turns.zero?
        puts 'The Computer Has Run Out Of Turns'
        break
      end
      @turns -= 1
    end
  end
end

game = Mastermind.new
game.computer_game