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
end
