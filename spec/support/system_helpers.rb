# frozen_string_literal: true

module SystemHelpers
  def login_as(user)
    visit new_user_session_path
    fill_in("email", with: user.email)
    fill_in("password", with: user.password)
    click_on("Log in")
  end
end