# Game Loop
class Mastermind
  def initialize
    @word_bank = %w[Red Blue Green Yellow Purple Orange Pink Brown Turquoise Lavender Indigo Cyan Maroon Olive Coral
                    Silver Gray Teal Gold Magenta]
    @turns = 12
  end

  def generate_secret
    @secret = @word_bank.sample.to_s.downcase
    puts @secret
  end

  def player_guess
    @guess = gets.chomp.to_s.downcase
  end

  def player_game
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
        puts 'game over'
        break
      end
    end
  end

  def correct_letter_count
    correct_count = 0

    @secret.chars.each_with_index do |char, index|
      correct_count += 1 if char == @guess[index]
    end
    correct_count
  end
end

game = Mastermind.new
game.generate_secret
game.player_game