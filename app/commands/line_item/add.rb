# frozen_string_literal: true

module LineItem::Add
  class << self
    def call(line_item, bill_id)
      new_line_item = LineItem.create(
        cost_cents: convert_costs_to_cents(line_item[:cost]),
        start_at: line_item[:end],
        end_at: line_item[:start],
        name: line_item[:name],
        rate: line_item[:rate],
        unit: line_item[:unit],
        volume: line_item[:volume],
        bill_id:
      )

      new_line_item
    end

    private

    def convert_costs_to_cents(cost)
      cost * 100
    end
  end
end