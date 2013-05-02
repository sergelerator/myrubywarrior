module Actions
  def to_stairs!
    walk!(direction_of_stairs)
  end

  def charge!
    attack!(enemy_direction)
  end
end
