require "warrior_senses"
require "warrior_actions"
require "warrior_helpers"

class Warrior

  THOUGHTS = {
    :numeric_disadvantage?                  => :paralyze!,
    :explosive_captives_on_level?           => {
      :explosive_captive_around?              => :unchain_explosive_captive!,
      :path_to_bomb_is_clear?                 => :approach_explosive_captive!,
      [:scratched?, :no_enemy_around?, :enemies_on_level?] => :heal!,
      :path_to_explosive_captive_blocked?     => {
        :dodgeable?                             => :dodge_obstacle!,
        [:enemy_ranks_around?, :health_yellow?, :captives_safe_from_bombs?] => :boom!,
        :default                                => :clear_path!
      },
      :default                                => :approach_explosive_captive!
    },
    :enemy_around?                          => :charge!,

    [:two_plus_enemies_on_level?, :scratched?, :no_enemy_around?] => :heal!,
    [:thick_sludge_left?, :bruised?, :no_enemy_around?] => :heal!,
    [:enemies_on_level?, :no_thick_sludges?, :injured?, :no_enemy_around?] => :heal!,

    :bound_enemies?                         => {
      :bound_enemy_around?                    => :attack_bound_enemy!,
      :captive_around?                        => :unchain!,
      :default                                => :approach_bound_enemy!
    },
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

  attr_reader :this, :bound_enemies, :prev_spot_direction

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
