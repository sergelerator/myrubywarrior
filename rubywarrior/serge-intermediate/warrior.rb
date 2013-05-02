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


    @prev_health = health
  end

  include Senses
  include Actions
  include Helpers

end
