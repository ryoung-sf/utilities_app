# frozen_string_literal: true

module LineItem::Add
  class << self
    def call(line_item, bill)
      new_line_item = LineItem.create(
        cost_cents: convert_costs_to_cents(line_item[:cost]),
        start_date: line_item[:end],
        end_date: line_item[:start],
        name: line_item[:name],
        rate_times_10000: multiply_rate_by_10k(line_item[:rate]),
        unit: line_item[:unit],
        volume_times_100: multiply_volume_by_100(line_item[:volume]),
        bill_id: bill.id
      )

      new_line_item
    end

    private

    def convert_costs_to_cents(cost)
      cost * 100
    end

    def multiply_rate_by_10k(rate)
      rate * 10000 unless rate.nil?
    end

    def multiply_volume_by_100(volume)
      volume * 100 unless volume.nil?
    end
  end
end