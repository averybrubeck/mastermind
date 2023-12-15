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

  def compare_choices
    loop do
      player_guess
      if @secret == @guess
        puts 'The Guess is Correct!'
        break
      end

      @turns -= 1
      puts "You Got It Wrong, turns left #{@turns}"

      if @turns.zero?
        puts 'game over'
        break
      end
    end
  end
end

game = Mastermind.new
game.generate_secret
game.compare_choices