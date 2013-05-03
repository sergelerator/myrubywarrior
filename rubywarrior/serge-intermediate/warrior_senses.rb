module Senses

  # ============================================================================
  # Senses data
  # ============================================================================
  MAX_HEALTH = 20
  DIRECTIONS = [:forward, :right, :backward, :left]

  # ============================================================================
  # Health related senses
  # ============================================================================

  def damaged?
    health < MAX_HEALTH
  end

  def scratched?
    health < (MAX_HEALTH * 0.80)
  end

  def injured?
    health < (MAX_HEALTH * 0.60)
  end

  def warning?
    health < (MAX_HEALTH * 0.40)
  end

  def danger?
    health < (MAX_HEALTH * 0.20)
  end

  def peril?
    health < (MAX_HEALTH * 0.10)
  end

  # ============================================================================
  # Check sorroundings
  # ============================================================================

  def enemy_around?
    directions.find{ |direction| feel(direction).enemy? }
  end

  def no_enemy_around?
    !enemy_around?
  end

  def under_attack?
    health < prev_health
  end

  def not_under_attack?
    !under_attack?
  end

  # ============================================================================
  # Misc
  # ============================================================================

  def directions
    DIRECTIONS
  end
end
