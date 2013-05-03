require "warrior_senses"
require "warrior_actions"
require "warrior_helpers"

class Warrior

  THOUGHTS = {
    :enemy_around?                          => :charge!,
    :scratched?  => {
      [:no_enemy_around?, :not_under_attack?] => :heal!
    },
    :default                                => :to_stairs!
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
        if k == :default
          return method(v).call
        elsif k.respond_to?(:map)
          if k.map{ |name| !!method(name).call }.reduce(true, &:&)
            return decide_with v
          end
        else
          return decide_with(v) if method(k).call
        end
      end
    elsif batch.is_a?(Symbol)
      return method(batch).call
    end
  end

  def thoughts
    THOUGHTS
  end

  include Senses
  include Actions
  include Helpers

end
