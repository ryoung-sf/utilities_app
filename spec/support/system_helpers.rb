# frozen_string_literal: true

module SystemHelpers
  def login_as(user)
    visit(login_path)
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    click_on("Login")
  end
end