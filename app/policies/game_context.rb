class GameContext
  attr_reader :game, :pincode

  def initialize(game, pincode)
    @game = game
    @pincode = pincode
  end
end
