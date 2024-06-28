# frozen_string_literal: true

module LineItem::FetchOne
  class << self
    def call(line_items, bill_id)
      line_items.each do |line_item|
        LineItem::Add.call(line_item, bill_id)
      end
    end
  end
end