# frozen_string_literal: true

class AuthorizationsController < ApplicationController
  def receive
    return "error" if received_authorization_params[:error] # needs error handling
    
    # request_params = { 
    #   referrals: received_authorization_params[:referral],
    #   include: "meters"
    # }
    # Authorization::FetchRawResponse.call(request_params)
    # SendApiRequestJob.set(good_job_labels: ["utility_request"])
    #   .perform_later(Authorization::FetchOne, request_params, current_user.id)
    # Authorization::FetchOne.call(request_params)
    redirect_to meters_path
  end

  private

  def received_authorization_params
    params.permit(:referral, :customer_email, :error, :error_description)
  end
end