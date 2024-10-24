class MetersController < ApplicationController
  def index
    if current_user.authorizations.empty?
      redirect_to new_request_form_path
    end

    meter = policy_scope(Meter).first
    if meter
      bills = meter.bills&.prior_6_months_statements(Time.zone.local(2024, 7, 1)).preload(:line_items)
      bill = bills.first
      readings = meter.readings&.occurred_between(bill.start_at, bill.end_at)
      render(locals: { bill: bill, bills: bills, readings: readings, user: current_user })
    end
  end

  def show
    @meter = Meter.find(params[:id])
    authorize(@meter)
  end

  def statement_date
    statement_date = params[:statement_date].to_date

    meter = policy_scope(Meter).first
    bills = meter.bills&.prior_6_months_statements(statement_date).preload(:line_items)
    bill = bills.first
    readings = meter.readings&.occurred_between(bill.start_at, bill.end_at)

    respond_to do |format|
      format.turbo_stream { 
        render turbo_stream: turbo_stream.replace("dashboard",
        partial: "meters/dashboard",
        locals: { bill: bill, bills: bills, readings: readings, user: current_user }) }
    end
  end
end