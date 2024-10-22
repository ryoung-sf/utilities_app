class MetersController < ApplicationController
  def index
    if current_user.authorizations.empty?
      redirect_to new_request_form_path
    end

    meter = policy_scope(Meter).first
    if meter
      # @bills = meter.bills&.statement_period_between(Time.zone.local(2024, 4, 1), Time.zone.local(2024, 7, 1)).preload(:line_items)
      bills = meter.bills&.prior_6_months_statements(Time.zone.local(2024, 4, 1)).preload(:line_items)
      bill = bills.first
      # readings = meter.readings&.occurred_between(Time.zone.local(2024, 6, 1), Time.zone.local(2024, 7, 1))
      readings = meter.readings&.occurred_between(bill.start_at, bill.end_at)
      render(locals: { bill: bill, bills: bills, readings: readings, user: current_user })
    end
  end

  def show
    @meter = Meter.find(params[:id])
    authorize(@meter)
  end

  # def update_month

  # end
end