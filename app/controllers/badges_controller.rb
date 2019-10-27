class BadgesController < ApplicationController
  def index
    @user_badges = current_user.badges
    @not_received_badges = current_user.not_received_badges
  end
end
