require 'warrior'

class Player

  def play_turn warrior
    @warrior = Warrior.new
    @warrior.go warrior
  end

end
