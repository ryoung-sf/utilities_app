# frozen_string_literal: true

module Bill::Add
  class << self
    def call(bill_response, meter_id)
      new_bill = Bill.create(
        external_uid: bill_response[:uid],
        start_at: bill_response[:base][:bill_start_date],
        end_at: bill_response[:base][:bill_end_date],
        statement_at: bill_response[:base][:bill_statement_date],
        raw_url: bill_response[:sources][0][:raw_url], # risky --> will I always want the first one
        total_kwh: bill_response[:base][:bill_total_kwh],
        total_unit: bill_response[:base][:bill_total_unit],
        total_volume: bill_response[:base][:bill_total_volume],
        total_cost_cents: convert_cost_to_cents(bill_response[:base][:bill_total_cost]),
        meter_id:
      )

      new_bill
    end

    private

    def convert_cost_to_cents(bill_total_cost)
      bill_total_cost * 100
    end

    def extract_line_items(bill_response)
      bill_response[:line_items]
    end
  end
end