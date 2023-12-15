# Game Loop\
class Mastermind
  def generate_secret
    word_bank = %w[Red Blue Green Yellow Purple Orange Pink Brown Turquoise Lavender Indigo Cyan Maroon Olive Coral Gold
                   Silver Gray Teal Magenta]
    secret = word_bank.sample.to_s.downcase
    puts secret
  end

  def player_guess
    guess = gets.chomp.to_s.downcase
    puts guess
  end
end

m = Mastermind.new
m.generate_secret
m.player_guess