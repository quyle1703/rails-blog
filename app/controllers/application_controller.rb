class ApplicationController < ActionController::Base
  def like_text
    return @like_exists ? "Unlike" : "Like"
  end

  helper_method :like_text
end
