class MetersController < ApplicationController
  def index
    @meters = current_user.meters.includes(:intervals)
    @bills = current_user.bills
  end
end
