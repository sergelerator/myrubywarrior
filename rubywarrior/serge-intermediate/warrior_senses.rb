module Senses

  # ============================================================================
  # Senses data
  # ============================================================================
  MAX_HEALTH = 20
  DIRECTIONS = [:forward, :right, :backward, :left]
  BINDING_ORDER = [:backward, :left, :right, :forward]

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

  def sorrounded?
    enemies_around > 2
  end

  def numeric_disadvantage?
    enemies_around >= 2
  end

  def enemy_around?
    enemies_around >= 1
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

  def bound_enemies?
    bound_enemies.length > 0
  end

  # ============================================================================
  # Misc
  # ============================================================================

  def directions
    DIRECTIONS
  end

  def bind_directions
    BINDING_ORDER
  end
end
