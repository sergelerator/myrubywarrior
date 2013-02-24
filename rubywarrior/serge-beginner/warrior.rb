require 'warrior_senses'
require 'warrior_actions'
require 'warrior_helpers'

class Warrior

  attr_reader :this

  def initialize
  end

  def method_missing meth, *args, &b
    this.send(meth, *args, &b)
  end

  def go warrior
    @this = warrior

    if dead_end? then pivot!
    elsif enemy_on_sight? and not under_attack? then shoot!
    elsif should_retreat? then retreat!
    elsif should_rest? then rest!
    elsif should_rescue? then rescue_captive!
    else charge!
    end

    @prev_health = health
  end

  include Senses
  include Actions
  include Helpers

end
