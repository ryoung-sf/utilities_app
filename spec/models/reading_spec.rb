require 'rails_helper'

RSpec.describe Reading, type: :model do
  describe "associations" do
    it "should belong to a meter" do
      reading = create(:reading)

      expect(reading).to belong_to(:meter)
    end
  end

  describe "scopes" do
    context "ordered" do
      it "should return readings ordered by end_at in descending order" do
        8.times do |i|
          create(:reading, start_at: Time.zone.local(2021, 1, i + 1), end_at: Time.zone.local(2021, 1, i + 2), value: rand + 1)
        end
  
        expect(Reading.ordered).to eq(Reading.order(end_at: :desc))
      end
    end

    context "occurred_between" do
      it "should return readings that occurred between start_date and end_date" do
        8.times do |i|
          create(:reading, start_at: Time.zone.local(2021, 1, i + 1), end_at: Time.zone.local(2021, 1, i + 2), value: rand + 1)
        end
  
        expect(Reading.occurred_between(Time.zone.local(2021, 1, 1), Time.zone.local(2021, 1, 3)).count).to eq(2)
      end

      it "should not return readings that occurred outside of start_date and end_date" do
        8.times do |i|
          create(:reading, start_at: Time.zone.local(2021, 1, i + 1), end_at: Time.zone.local(2021, 1, i + 2), value: rand + 1)
        end

        new_reading = Reading.find_by(start_at: Time.zone.local(2021, 1, 4))
        expect(Reading.occurred_between(Time.zone.local(2021, 1, 1), Time.zone.local(2021, 1, 3))).not_to include new_reading
      end
    end
  end

  describe "class methods" do
    context "total_kwh_usage_per_day" do
      it "should return total kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end

        expect(Reading.total_kwh_usage_per_day).to eq(
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).sum(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).sum(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).sum(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).sum(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).sum(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).sum(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).sum(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).sum(:value),
        )
      end
    end

    context "peak_kwh_usage_per_day" do
      it "should return peak kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end

        expect(Reading.peak_kwh_usage_per_day).to eq(
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).maximum(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).maximum(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).maximum(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).maximum(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).maximum(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).maximum(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).maximum(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).maximum(:value),
        )
      end
    end

    context "average_kwh_usage_per_day" do
      it "should return average kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end
  
        expect(Reading.average_kwh_usage_per_day).to eq(
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).average(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).average(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).average(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).average(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).average(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).average(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).average(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).average(:value),
        )
      end
    end

    context "max_total_kwh_usage_per_day" do
      it "should return max total kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end

        daily_kwh_usage = {
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).sum(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).sum(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).sum(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).sum(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).sum(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).sum(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).sum(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).sum(:value),
        }

        expect(Reading.max_total_kwh_usage_per_day).to eq(daily_kwh_usage.values.max)
      end
    end

    context "min_total_kwh_usage_per_day" do
      it "should return min total kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end

        daily_kwh_usage = {
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).sum(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).sum(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).sum(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).sum(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).sum(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).sum(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).sum(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).sum(:value),
        }

        expect(Reading.min_total_kwh_usage_per_day).to eq(daily_kwh_usage.values.min)
      end
    end

    context "max_peak_kwh_usage_per_day" do
      it "should return max peak kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end

        daily_kwh_usage = {
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).maximum(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).maximum(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).maximum(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).maximum(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).maximum(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).maximum(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).maximum(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).maximum(:value),
        }

        expect(Reading.max_peak_kwh_usage_per_day).to eq(daily_kwh_usage.values.max)
      end
    end

    context "min_peak_kwh_usage_per_day" do
      it "should return min peak kwh usage per day" do
        8.times do |i|
          24.times do |j|
            create(:reading, start_at: Time.zone.local(2021, 1, i + 1, j, 0, 0), end_at: Time.zone.local(2021, 1, i + 2, j + 1, 0, 0), value: rand + 1)
          end
        end

        daily_kwh_usage = {
          "Fri, 01 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 1, 0, 0, 0), Time.zone.local(2021, 1, 3, 0, 0, 0)).maximum(:value),
          "Sat, 02 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 2, 0, 0, 0), Time.zone.local(2021, 1, 4, 0, 0, 0)).maximum(:value),
          "Sun, 03 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 3, 0, 0, 0), Time.zone.local(2021, 1, 5, 0, 0, 0)).maximum(:value),
          "Mon, 04 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 4, 0, 0, 0), Time.zone.local(2021, 1, 6, 0, 0, 0)).maximum(:value),
          "Tue, 05 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 5, 0, 0, 0), Time.zone.local(2021, 1, 7, 0, 0, 0)).maximum(:value),
          "Wed, 06 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 6, 0, 0, 0), Time.zone.local(2021, 1, 8, 0, 0, 0)).maximum(:value),
          "Thu, 07 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 7, 0, 0, 0), Time.zone.local(2021, 1, 9, 0, 0, 0)).maximum(:value),
          "Fri, 08 Jan 2021".to_date => Reading.occurred_between(Time.zone.local(2021, 1, 8, 0, 0, 0), Time.zone.local(2021, 1, 10, 0, 0, 0)).maximum(:value),
        }

        expect(Reading.min_peak_kwh_usage_per_day).to eq(daily_kwh_usage.values.min)
      end
    end
  end
end

# == Schema Information
#
# Table name: readings
#
#  id          :uuid             not null, primary key
#  start_at    :datetime         not null
#  end_at      :datetime         not null
#  unit        :string           not null
#  volume_type :string           not null
#  meter_id    :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :decimal(10, 6)   default(0.0)
#
