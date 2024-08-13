class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :pundishing_user

  before_action :authenticate_user!

  private
  
  def pundishing_user
    flash[:notice] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
