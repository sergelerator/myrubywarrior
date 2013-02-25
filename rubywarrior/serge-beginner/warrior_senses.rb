module Senses

  # ===============================================================================================
  # Senses data
  # ===============================================================================================
  MaxHealth = 20


  # ===============================================================================================
  # Health related senses
  # ===============================================================================================

  def damaged?
    health < MaxHealth
  end

  def scratched?
    health < (MaxHealth * 0.80)
  end

  def injured?
    health < (MaxHealth * 0.50)
  end

  def warning?
    health < (MaxHealth * 0.33)
  end

  def danger?
    health < (MaxHealth * 0.25)
  end

  def peril?
    health < (MaxHealth * 0.15)
  end

  # ===============================================================================================
  # Danger related senses
  # ===============================================================================================

  def under_attack?
    health < prev_health
  end

  def enemy_on_sight?
    (@line_of_sight = look.compact.reject(&:empty?)) == [] ? false : @line_of_sight.first.enemy?
  end

  def danger_behind?
    (@line_of_sight = look(:backward).compact.reject(&:empty?)) == [] ? false : @line_of_sight.first.enemy? and under_attack?
  end

  def should_retreat?
    feel(:backward).empty? and danger? and under_attack?
  end

  # ===============================================================================================
  # Checking near-by stuff
  # ===============================================================================================

  def dead_end?
    feel.wall?
  end

  def should_rest?
    feel.empty? and scratched? and not under_attack?
  end

  def should_rescue?
    feel(dir).captive?
  end

  def captive_behind?
    (@line_of_sight = look(:backward).compact.reject(&:empty?)) == [] ? false : @line_of_sight.first.captive?
  end

  def stairs_on_sight?
    (@line_of_sight = look.compact.reject(&:empty?)) == [] ? false : @line_of_sight.first.stairs?
  end
end
