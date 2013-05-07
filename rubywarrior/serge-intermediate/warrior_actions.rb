module Actions
  def to_stairs!
    prev_spot_direction = opposite_direction_of(direction_of_stairs)
    walk!(direction_of_stairs)
  end

  def approach_enemy!
    prev_spot_direction = opposite_direction_of(enemy_direction)
    walk!(enemy_direction)
  end

  def approach_bound_enemy!
    prev_spot_direction = opposite_direction_of(bound_enemy_direction)
    walk!(bound_enemy_direction)
  end

  def approach_captive!
    prev_spot_direction = opposite_direction_of(captive_direction)
    walk!(captive_direction)
  end

  def approach_explosive_captive!
    prev_spot_direction = opposite_direction_of(explosive_captive_direction)
    walk!(explosive_captive_direction)
  end

  def charge!
    attack!(enemy_direction)
  end

  def clear_path!
    attack!(explosive_captive_direction)
  end

  def attack_bound_enemy!
    #attack!(bound_enemies.pop)
    attack!(direction_of(bound_enemies.pop))
  end

  def heal!
    rest!
  end

  def paralyze!
    #bound_enemies.push(bind_direction)
    bound_enemies.push(feel(bind_direction))
    bind!(bind_direction)
  end

  def unchain!
    rescue!(captive_direction)
  end

  def unchain_explosive_captive!
    rescue!(explosive_captive_direction)
  end

  def dodge_obstacle!
    prev_spot_direction = opposite_direction_of(empty_spot_direction)
    walk!(empty_spot_direction)
  end

  def boom!
    detonate!(enemy_ranks_direction)
  end
end
