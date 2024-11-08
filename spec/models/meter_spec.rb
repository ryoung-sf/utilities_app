require 'rails_helper'

RSpec.describe Meter, type: :model do
  
  def create_meter(params: {})
    create(:meter, params)
  end

  describe "associations" do
    it "should belong to a user" do
      meter = create_meter
      expect(meter).to belong_to(:user)
    end

    it "should belong to an authorization" do
      meter = create_meter
      expect(meter).to belong_to(:authorization)
    end

    it "should have many readings" do
      meter = create_meter
      expect(meter).to have_many(:readings).dependent(:destroy)
    end

    it "should have many bills" do
      meter = create_meter
      expect(meter).to have_many(:bills)
    end
  end

  describe "delegations" do
    it "should delegate occurred_between to readings" do
      meter = create_meter
      create(:reading, meter: meter)
      expect(meter).to delegate_method(:occurred_between).to(:readings)
    end
  end

  # describe "class methods" do

  # end

  describe "instance methods" do
    context "bills_statement_date_between" do
      it "should return bills with statement date between start_date and end_date" do
        meter = create(:meter)
        8.times do |i|
          create(:bill, statement_at: Date.new(2021, i + 1, 1), meter: meter)
        end

        expect(meter.bills_statement_date_between(Date.new(2021, 1, 1), Date.new(2021, 3, 1)).count).to eq(3)
      end

      it "should return all bills if start_date and end_date are nil" do
        meter = create(:meter)
        8.times do |i|
          create(:bill, statement_at: Date.new(2021, i + 1, 1), meter: meter)
        end

        expect(meter.bills_statement_date_between(nil, nil).count).to eq(8)
      end
    end

    context "bills_statement_period_between" do
      it "should return bills with statement period between start_date and end_date" do
        meter = create(:meter)
        8.times do |i|
          create(:bill, start_at: Date.new(2021, i + 1, 1), end_at: Date.new(2021, i + 1, 1), meter: meter)
        end

        expect(meter.bills_statement_period_between(Date.new(2021, 1, 1), Date.new(2021, 3, 1)).count).to eq(3)
      end

      it "should return all bills if start_date and end_date are nil" do
        meter = create(:meter)
        8.times do |i|
          create(:bill, start_at: Date.new(2021, i + 1, 1), end_at: Date.new(2021, i + 1, 1), meter: meter)
        end

        expect(meter.bills_statement_period_between(nil, nil).count).to eq(8)
      end
    end

    context "total_kwh_per_day" do
      it "should return total kwh per day for ranged readings" do
        meter = create(:meter)
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0) , value: rand + 1, meter: meter)
          end
        end

        expect(meter.total_kwh_per_day(meter.readings).values.sum).to eq(meter.readings.pluck(:value).sum)
        expect(meter.total_kwh_per_day(meter.readings)).to eq(
          "Fri, 01 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).sum(:value),
          "Sat, 02 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).sum(:value),
          "Sun, 03 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).sum(:value),
          "Mon, 04 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).sum(:value),
          "Tue, 05 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).sum(:value),
          "Wed, 06 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).sum(:value),
          "Thu, 07 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).sum(:value),
          "Fri, 08 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).sum(:value),
        )
      end
    end

    context "max_hourly_kwh_per_day" do
      it "should return max hourly kwh per day for ranged readings" do
        meter = create(:meter)
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0) , value: rand + 1, meter: meter)
          end
        end

        expect(meter.max_hourly_kwh_per_day(meter.readings)).to eq(
          "Fri, 01 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).maximum(:value),
          "Sat, 02 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).maximum(:value),
          "Sun, 03 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).maximum(:value),
          "Mon, 04 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).maximum(:value),
          "Tue, 05 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).maximum(:value),
          "Wed, 06 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).maximum(:value),
          "Thu, 07 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).maximum(:value),
          "Fri, 08 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).maximum(:value),
        )
      end
    end

    context "average_kwh_per_day" do
      it "should return average hourly kwh per day for ranged readings" do
        meter = create(:meter)
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0) , value: rand + 1, meter: meter)
          end
        end

        expect(meter.average_kwh_per_day(meter.readings)).to eq(
          "Fri, 01 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).average(:value),
          "Sat, 02 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).average(:value),
          "Sun, 03 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).average(:value),
          "Mon, 04 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).average(:value),
          "Tue, 05 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).average(:value),
          "Wed, 06 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).average(:value),
          "Thu, 07 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).average(:value),
          "Fri, 08 Jan 2021".to_date => meter.readings.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).average(:value),
        )
      end
    end
  end
end

# == Schema Information
#
# Table name: meters
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  service_class    :string
#  service_id       :string           not null
#  service_tariff   :string
#  activated_at     :datetime         not null
#  utility_meter_id :string           not null
#  status_at        :datetime         not null
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  authorization_id :uuid             not null
#  status_message   :string
#  notes            :jsonb
#  bill_count       :integer          default(0), not null
#
