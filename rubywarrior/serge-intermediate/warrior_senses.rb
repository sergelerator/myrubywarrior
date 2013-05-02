module Senses

  # ===============================================================================================
  # Senses data
  # ===============================================================================================
  MaxHealth = 20


  # ===============================================================================================
  # Health related senses
  # ===============================================================================================

  def damaged?
    health < MaxHealth
  end

  def scratched?
    health < (MaxHealth * 0.80)
  end

  def injured?
    health < (MaxHealth * 0.50)
  end

  def warning?
    health < (MaxHealth * 0.33)
  end

  def danger?
    health < (MaxHealth * 0.25)
  end

  def peril?
    health < (MaxHealth * 0.15)
  end
end
