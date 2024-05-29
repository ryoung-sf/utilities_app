# frozen_string_literal: true

module Meter::Add
  class << self
    def call(meter)
      meter = Meter.create(
        external_uid: meter[:uid],
        service_class: meter[:base][:service_class],
        service_id: meter[:base][:service_identifier],
        service_tariff: meter[:base][:service_tariff],
        created_date: meter[:created],
        utility_meter_id: meter[:base][:meter_numbers][0],
        status_date: meter[:status_ts],
        status: meter[:status_message],
        authorization_id: Authorization.find_by(external_uid: meter[:authorization_uid]).id,
      )

      meter
    end
  end
end