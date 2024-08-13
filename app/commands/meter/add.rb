# frozen_string_literal: true

module Meter::Add
  class << self
    def call(meter, auth_id, user_id)
      meter = Meter.create(
        external_uid: meter[:uid],
        service_class: meter[:base][:service_class],
        service_id: meter[:base][:service_identifier],
        service_tariff: meter[:base][:service_tariff],
        activated_at: meter[:created],
        utility_meter_id: meter[:base][:meter_numbers][0],
        status_at: meter[:status_ts],
        status: meter[:status],
        status_message: meter[:status_message],
        notes: meter[:notes],
        authorization_id: auth_id,
        user_id:
      )

      meter
    end
  end
end