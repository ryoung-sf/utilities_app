# frozen_string_literal: true

class RequestFormsController < ApplicationController
  def new
  end

  def create
    url = RequestForm::Create.call(request_forms_params.to_hash, current_user.id)
    redirect_to url, allow_other_host: true, target: "blank"
  end

  private

  def request_forms_params
    params.permit(:customer_email, :utility)
  end
end
