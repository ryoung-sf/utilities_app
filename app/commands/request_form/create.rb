# frozen_string_literal: true

module RequestForm::Create
  class << self
    def call(params, user_id)
      new_form = create_new_form(params)
      new_form[:url]
    end

    private

    def create_new_form(params)
      res = connection.create_form(params)
      res[:body]
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end