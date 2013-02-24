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

  def injured?
    health < (MaxHealth / 2)
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

  def should_retreat?
    feel(:backward).empty? and injured? and under_attack?
  end

  # ===============================================================================================
  # Checking near-by stuff
  # ===============================================================================================

  def dead_end?
    feel.wall?
  end

  def should_rest?
    feel.empty? and damaged? and not under_attack?
  end

  def should_rescue?
    feel(dir).captive?
  end
end
