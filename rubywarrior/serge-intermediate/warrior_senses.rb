module Senses

  # ============================================================================
  # Senses data
  # ============================================================================
  MAX_HEALTH = 20
  DIRECTIONS = [:forward, :right, :backward, :left]
  BINDING_ORDER = [:backward, :left, :right, :forward]
  DODGE_PRIORITIES = [:forward, :right, :left, :backward]
  DIRECTION_OPPOSITES = {
    forward:    :backward,
    backward:   :forward,
    left:       :right,
    right:      :left
  }

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


  def health_green?
    health >= (MAX_HEALTH * 0.60)
  end

  def health_yellow?
    health >= (MAX_HEALTH * 0.30)
  end

  def health_red?
    health < (MAX_HEALTH * 0.30)
  end

  # ============================================================================
  # Check sorroundings
  # ============================================================================

  def sorrounded?
    enemies_around > 2
  end

  def numeric_disadvantage?
    enemies_around > 1
  end

  def enemy_around?
    enemies_around > 0
  end

  def bound_enemy_around?
    distance_of(bound_enemies.last) == 1
  end

  def no_enemy_around?
    !enemy_around?
  end

  def enemy_ranks_around?
    enemy_ranks_around > 0
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

  def captive_around?
    captives_around > 0
  end

  def enemies_on_level?
    enemies_on_level > 0 || bound_enemies?
  end

  def captives_on_level?
    captives_on_level > 0
  end

  def path_to_enemy_blocked?
    feel(enemy_direction).stairs?
  end

  def path_to_captive_blocked?
    feel(captive_direction).stairs?
  end

  # ============================================================================
  # Dealing with explosive captives
  # ============================================================================

  def explosive_captive_around?
    explosive_captives_around >= 1
  end

  def explosive_captives_on_level?
    explosive_captives_on_level > 0
  end

  def path_to_explosive_captive_blocked?
    feel(explosive_captive_direction).stairs? ||
      !feel(explosive_captive_direction).empty?
  end

  def dodgeable?
    dodge_priorities.
      reject{ |p| p == prev_spot_direction }.
      count{ |d| d.empty? } > 0
  end

  def path_to_bomb_is_clear?
    look(explosive_captive_direction).
      count{ |s| s.enemy? || (s.captive? && !s.ticking?) } == 0
  end

  def captives_safe_from_bombs?
    listen.select(&:ticking?).count{ |c| distance_of(c) == 2 } == 0
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

  def dodge_priorities
    DODGE_PRIORITIES
  end

  def direction_opposites
    DIRECTION_OPPOSITES
  end
end
