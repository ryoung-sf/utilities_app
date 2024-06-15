class RequestFormsController < ApplicationController
  def new
  end

  def create
    RequestForm::Create.call(request_forms_params.to_hash, current_user.id)
  end

  private

  def request_forms_params
    params.permit(:customer_email, :utility)
  end
end
