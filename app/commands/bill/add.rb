# frozen_string_literal: true

module Bill::Add
  class << self
    def call(bill_response)
      new_bill = Bill.create(
        external_uid: bill_response[:uid],
        start_date: bill_response[:base][:bill_start_date],
        end_date: bill_response[:base][:bill_end_date],
        statement_date: bill_response[:base][:bill_statement_date],
        raw_url: bill_response[:sources][0][:raw_url], # risky --> will I always want the first one
        total_kwh_times_100: multiply_total_kwh_by_100(bill_response[:base][:bill_total_kwh]),
        total_unit: bill_response[:base][:bill_total_unit],
        total_volume_times_100: multiply_volume_by_100(bill_response[:base][:bill_total_volume]),
        total_cost_cents: convert_cost_to_cents(bill_response[:base][:bill_total_cost]),
        authorization_id: Authorization.find_by(external_uid: (bill_response[:authorization_uid])).id,
      )

      LineItem::FetchOne.call(bill_response[:line_items], new_bill) if bill_response[:line_items]

      new_bill
    end

    private

    def multiply_total_kwh_by_100(bill_total_kwh)
      bill_total_kwh * 100 unless bill_total_kwh.nil?
    end

    def multiply_volume_by_100(bill_total_volume)
      bill_total_volume * 100 unless bill_total_volume.nil?
    end

    def convert_cost_to_cents(bill_total_cost)
      bill_total_cost * 100
    end

    def extract_line_items(bill_response)
      bill_response[:line_items]
    end
  end
end