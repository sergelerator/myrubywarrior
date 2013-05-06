require "warrior_senses"
require "warrior_actions"
require "warrior_helpers"

class Warrior

  THOUGHTS = {
    :numeric_disadvantage?                  => :paralyze!,
    :enemy_around?                          => :charge!,
    :scratched?  => {
      [:no_enemy_around?, :not_under_attack?] => :heal!
    },
    :bound_enemies?                         => :attack_bound_enemy!,
    :captive_around?                        => :unchain!,
    :enemies_on_level?                      => {
      :path_to_enemy_blocked?                 => :dodge_obstacle!,
      :default                                => :approach_enemy!
    },
    :captives_on_level?                     => {
      :path_to_captive_blocked?               => :dodge_obstacle!,
      :default                                => :approach_captive!
    },
    :default                                => :to_stairs!
  }

  attr_reader :this, :bound_enemies

  def initialize
    @bound_enemies = []
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
