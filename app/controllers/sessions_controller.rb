class SessionsController < Devise::SessionsController
  def create
    super
    set_flash_message(
      :notice, :signed_in_hello, full_name: current_user.full_name
    )
  end
end