# frozen_string_literal: true

module Bill::FindNewMeters
  class << self
    def call(raw_bills)
      bills = []

      raw_bills.each do |bill|
        next if Bill.exists?(external_uid: bill[:uid])

        bills << bill
      end

      bills
    end
  end
end