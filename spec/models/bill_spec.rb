require 'rails_helper'

RSpec.describe Bill, type: :model do

  describe "validations" do
    it "is valid with valid attributes" do
      bill = create(:bill)
      expect(bill).to be_valid
    end

    it "is not valid without a start_at" do
      bill = build(:bill, start_at: nil)
      expect(bill).to_not be_valid
    end

    it "is not valid without a end_at" do
      bill = build(:bill, end_at: nil)
      expect(bill).to_not be_valid
    end

    it "is not valid without a external_uid" do
      bill = build(:bill, external_uid: nil)
      expect(bill).to_not be_valid
    end

    it "is not valid without a meter_id" do
      bill = build(:bill, meter_id: nil)
      expect(bill).to_not be_valid
    end
  end

  describe "monetize" do
    it "should monetize total_cost_cents" do
      is_expected.to monetize(:total_cost)
    end
  end

  describe "scopes" do
    context "ordered" do
      it "should return bills ordered by statement_at" do
        create(:bill, statement_at: Date.new(2021, 1, 1))
        create(:bill, statement_at: Date.new(2021, 2, 1))
        create(:bill, statement_at: Date.new(2021, 3, 1))
        expect(Bill.ordered.pluck(:statement_at)).to eq([Date.new(2021, 3, 1), Date.new(2021, 2, 1), Date.new(2021, 1, 1)])
      end
    end

    context "statement_date_between" do
      it "shoud return bills with statement date between start_date and end_date" do
        create(:bill, statement_at: Date.new(2021, 1, 1))
        create(:bill, statement_at: Date.new(2021, 2, 1))
        create(:bill, statement_at: Date.new(2021, 3, 1))
        expect(Bill.statement_date_between(Date.new(2021, 1, 1), Date.new(2021, 2, 1)).pluck(:statement_at)).to eq([Time.zone.local(2021, 1, 1), Time.zone.local(2021, 2, 1)])
      end
    end

    context "statement_period_between" do
      it "should return bills with statement period between start_date and end_date" do
        create(:bill, start_at: Date.new(2021, 1, 1), end_at: Date.new(2021, 1, 31))
        create(:bill, start_at: Date.new(2021, 2, 1), end_at: Date.new(2021, 2, 28))
        create(:bill, start_at: Date.new(2021, 3, 1), end_at: Date.new(2021, 3, 31))
        expect(Bill.statement_period_between(Date.new(2021, 1, 1), Date.new(2021, 2, 1)).pluck(:start_at)).to eq([Time.zone.local(2021, 1, 1)])
      end
    end

    context "prior_6_months_statements" do
      it "should return bills with statement date between 5 months ago and end_date" do
        8.times do |i|
          create(:bill, statement_at: Date.new(2021, i + 1, 1))
        end

        expect(Bill.prior_6_months_statements(Date.new(2021, 8, 1)).pluck(:statement_at)).to eq([Time.zone.local(2021, 3, 1), Time.zone.local(2021, 4, 1), Time.zone.local(2021, 5, 1), Time.zone.local(2021, 6, 1), Time.zone.local(2021, 7, 1), Time.zone.local(2021, 8, 1)])
      end
    end

    context "prior_year_statements" do
      it "should return bills with statement date between 12 months ago and end_date" do
        8.times do |i|
          create(:bill, statement_at: Date.new(2021, i + 1, 1))
        end
  
        expect(Bill.prior_year_statements(Date.new(2021, 8, 1)).pluck(:statement_at)).to eq([Time.zone.local(2021, 1, 1), Time.zone.local(2021, 2, 1), Time.zone.local(2021, 3, 1), Time.zone.local(2021, 4, 1), Time.zone.local(2021, 5, 1), Time.zone.local(2021, 6, 1), Time.zone.local(2021, 7, 1), Time.zone.local(2021, 8, 1)])
      end
    end
  end

  describe "class methods" do
    context "bills_by_month_year" do
      it "should return the sum of total cost by month and year" do
        create(:bill, total_cost_cents: 1000, statement_at: Date.new(2021, 1, 1))
        create(:bill, total_cost_cents: 500, statement_at: Date.new(2021, 2, 1))
        expect(Bill.bills_by_month_year).to eq({ "Jan 21" => 10.0, "Feb 21" => 5.0 })
      end
    end

    # context "change_in_total_kwh" do
    #   it "should return the change in total kwh" do
    #     create(:bill, total_kwh: 1000, statement_at: Date.new(2021, 1, 1))
    #     create(:bill, total_kwh: 500, statement_at: Date.new(2021, 2, 1))
    #     expect(Bill.change_in_total_kwh).to eq([-50.0])
    #   end
    # end
  end

  describe "instance methods" do
    context "change_in_total_kwh" do
      it "should return the change in total cost" do
        bill = create(:bill, total_cost_cents: 1000)
        create(:bill, total_cost_cents: 500, start_at: bill.start_at - 1.month, end_at: bill.end_at - 1.month, statement_at: bill.statement_at - 1.month)
        expect(bill.change_in_total_cost).to eq(100.0)
      end
  
      it "should return 0 if there is no prior bill" do
        bill = create(:bill, total_cost_cents: 1000)
        expect(bill.change_in_total_cost).to eq(0)
      end
    end

    context "change_in_total_kwh" do
      it "should return the change in total kwh" do
        bill = create(:bill, total_kwh: 1000)
        create(:bill, total_kwh: 500, start_at: bill.start_at - 1.month, end_at: bill.end_at - 1.month, statement_at: bill.statement_at - 1.month)
        expect(bill.change_in_total_kwh).to eq(100.0)
      end

      it "should return 0 if there is no prior bill" do
        bill = create(:bill, total_kwh: 1000)
        expect(bill.change_in_total_kwh).to eq(0)
      end
    end
  end

  describe "associations" do
    it "should belong to meter" do
      bill = create(:bill)
      expect(bill).to belong_to(:meter)
    end

    it "should have many line items" do
      bill = create(:bill)
      expect(bill).to have_many(:line_items)
    end
  end
end

# == Schema Information
#
# Table name: bills
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  start_at         :datetime         not null
#  end_at           :datetime         not null
#  total_unit       :string
#  total_cost_cents :integer
#  raw_url          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  statement_at     :datetime
#  meter_id         :uuid             not null
#  total_kwh        :decimal(10, 6)   default(0.0)
#  total_volume     :decimal(10, 6)   default(0.0)
#
