module Actions
  def to_stairs!
    walk!(direction_of_stairs)
  end

  def approach_enemy!
    walk!(direction_of(enemy_direction))
  end

  def approach_captive!
    walk!(direction_of(captive_direction))
  end

  def charge!
    attack!(enemy_direction)
  end

  def attack_bound_enemy!
    attack!(bound_enemies.pop)
  end

  def heal!
    rest!
  end

  def paralyze!
    bound_enemies.push(bind_direction)
    bind!(bind_direction)
  end

  def unchain!
    rescue!(captive_direction)
  end
end
