module Helpers
  def dir
    :forward
  end

  def prev_health
    @prev_health ||= health
  end
end
