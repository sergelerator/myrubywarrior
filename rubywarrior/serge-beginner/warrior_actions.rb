module Actions
  def charge!
    feel(dir).empty? ? walk!(dir) : feel(dir).enemy? ? attack!(dir) : rest!
  end

  def rescue_captive!
    rescue!(dir)
  end

  def retreat!
    walk!(:backward)
  end

  def walk_back!
    walk!(:backward)
  end

  def unchain_back!
    rescue!(:backward)
  end

  def fire!
    shoot!
  end

  def advance!
    walk!
  end

  def heal!
    rest!
  end

  def turn_around!
    pivot!
  end
end
