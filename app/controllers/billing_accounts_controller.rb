# frozen_string_literal: true

class BillingAccountsController < ApplicationController
  def index
    if current_user.billing_accounts.empty?
      redirect_to new_request_form_path
    end
  end
end