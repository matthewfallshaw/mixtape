module TapestersHelper
  def tapester_at_home?
    tapester_signed_in? && ( @tapester == current_tapester )
  end
end
