# Represents a participant in the game, storing their identity and game symbol.
class Player
  # @param name [String] the player's name
  # @param mark [String] the player's symbol (x or o)
  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def move(row, column)
    # TODO
  end
end
