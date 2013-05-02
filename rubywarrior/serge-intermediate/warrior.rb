require "warrior_senses"
require "warrior_actions"
require "warrior_helpers"

class Warrior

  THOUGHTS = {
    [:enemy_around?]  => :charge!,
    :default          => :to_stairs!
  }

  attr_reader :this

  def initialize
  end

  def method_missing meth, *args, &b
    this.method(meth).call(*args, &b)
  end

  def go warrior
    @this = warrior

    decide_with thoughts

    @prev_health = health
  end

  def decide_with batch
    if batch.respond_to?(:each_pair)
      batch.each_pair do |k, v|

      end
    elsif batch.respond_to?(:each)
      batch.each{ |name| method(name).call }.reduce(true, &:&)
    end
  end

  def thoughts
    THOUGHTS
  end

  include Senses
  include Actions
  include Helpers

end
