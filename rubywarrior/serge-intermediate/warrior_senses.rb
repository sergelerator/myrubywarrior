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
    health < (MAX_HEALTH * 0.50)
  end

  def warning?
    health < (MAX_HEALTH * 0.33)
  end

  def danger?
    health < (MAX_HEALTH * 0.25)
  end

  def peril?
    health < (MAX_HEALTH * 0.15)
  end

  # ============================================================================
  # Check sorroundings
  # ============================================================================

  def enemy_around?
    directions.find{ |direction| feel(direction).enemy? }
  end

  # ============================================================================
  # Misc
  # ============================================================================

  def directions
    DIRECTIONS
  end
end
