module Helpers
  def dir
    :forward
  end

  def prev_health
    @prev_health ||= health
  end

  def enemy_direction
    thing_direction :enemy?
  end

  def captive_direction
    thing_direction :captive?
  end

  def explosive_captive_direction
    thing_direction :ticking?
  end

  def bind_direction
    bind_directions.find{ |d| feel(d).enemy? }
  end

  def thing_direction(thing_label)
    directions.find{ |d| feel(d).method(thing_label).call } ||
      direction_of(listen.find(&thing_label))
  end

  def enemies_around
    things_around :enemy?
  end

  def captives_around
    things_around :captive?
  end

  def explosive_captives_around
    things_around :ticking?
  end

  def things_around(thing_label)
    directions.map{ |d| feel(d) }.count(&thing_label)
  end


  def enemies_on_level
    listen.count(&:enemy?)
  end

  def captives_on_level
    listen.count(&:captive?)
  end

  def explosive_captives_on_level
    listen.count(&:ticking?)
  end

  def things_on_level
    listen.length
  end

  def empty_spot_direction
    dodge_priorities.find{ |d| feel(d).empty? and !feel(d).stairs? }
  end
end
