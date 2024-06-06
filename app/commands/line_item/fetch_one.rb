# frozen_string_literal: true

module LineItem::FetchOne
  class << self
    def call(line_items, bill)
      line_items.each do |line_item|
        LineItem::Add.call(line_item, bill)
      end
    end
  end
end