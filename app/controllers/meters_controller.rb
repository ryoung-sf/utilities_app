class MetersController < ApplicationController
  def index
    if current_user.authorizations.empty?
      redirect_to new_request_form_path
    end
  end
end
