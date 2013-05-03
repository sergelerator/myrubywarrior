module Helpers
  def dir
    :forward
  end

  def enemy_direction
    directions.find{ |direction| feel(direction).enemy? }
  end

  def bind_direction
    bind_directions.find{ |direction| feel(direction).enemy? }
  end

  def prev_health
    @prev_health ||= health
  end

  def enemies_around
    directions.map{ |d| feel(d).enemy? }.compact.length
  end
end
