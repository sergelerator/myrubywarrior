require 'warrior_senses'
require 'warrior_actions'
require 'warrior_helpers'

class Warrior

  attr_reader :this

  def initialize
  end

  def method_missing meth, *args, &b
    this.method(meth).call(*args, &b)
  end

  def go warrior
    @this = warrior

    if dead_end? then pivot!
    elsif captive_behind? then (feel(:backward).empty? ? walk!(:backward) : rescue!(:backward))
    elsif danger_behind? and feel.empty? then walk!
    elsif enemy_on_sight? and feel.empty? then shoot!
    elsif should_retreat? then retreat!
    elsif should_rescue? then rescue_captive!
    elsif stairs_on_sight? then walk!
    elsif should_rest? then rest!
    else charge!
    end

    @prev_health = health
  end

  include Senses
  include Actions
  include Helpers

end
