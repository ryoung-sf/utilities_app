# frozen_string_literal: true

class RequestFormsController < ApplicationController
  def new
  end

  def create
    url = RequestForm::Create.call(add_attributes_to_params, current_user.id)
    redirect_to url, allow_other_host: true, target: "blank"
  end

  private

  def request_forms_params
    params.permit(:customer_email, :utility, :scope)
  end

  def add_attributes_to_params
    params = request_forms_params.to_hash
    params[:scope] = { autocollect: true }
    params[:include] = "meters"
    params
  end
end
