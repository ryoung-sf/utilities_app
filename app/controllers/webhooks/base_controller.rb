# frozen_string_literal: true

class Webhooks::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  skip_forgery_protection

  before_action :verify_event unless Rails.env.test?

  def create
    InboundWebhook.create(body: payload)
    head 200
  end

  private

  def verify_event
    head :bad_request
  end

  def payload
    @payload ||= request.body.read
  end
end
