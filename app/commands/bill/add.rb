# frozen_string_literal: true

module Bill::Add
  class << self
    def call(bill)
      bill = Bill.new(
        external_uid: bill[:uid],
        start_date: bill[:base][:billing_start_date],
        end_date: bill[:base][:billing_end_date],
        total_kwh_times_100: some_kwh_conversion_method(bill[:base][:bill_total_kwh]),
        total_unit: bill[:base][:bill_total_unit],
        total_volume_times_100: some_volume_conversion_method(bill[:base][:bill_total_volume]),
        total_cost_cents: some_cost_conversion_method(bill[:base][:bill_total_cost]),
        authorization_id: Authorization.find_by(external_uid: (bill[:authorizaiton_uid])),
      )

      bill
    end
  end
end