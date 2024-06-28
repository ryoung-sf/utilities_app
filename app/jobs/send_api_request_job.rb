# frozen_string_literal: true

class SendApiRequestJob < ApplicationJob
  queue_as :default

  def perform(callable, params, *options)
    callable.call(params, *options)
  end
end
