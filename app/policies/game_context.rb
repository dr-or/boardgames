class GameContext
  attr_reader :game, :pincode

  def initialize(game:, pincode: nil)
    @game = game
    @pincode = pincode
  end
end
