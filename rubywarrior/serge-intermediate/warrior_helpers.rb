module Helpers
  def dir
    :forward
  end

  def enemy_direction
    directions.find{ |direction| feel(direction).enemy? }
  end

  def prev_health
    @prev_health ||= health
  end
end
