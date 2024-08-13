class MetersController < ApplicationController
  def index
    if current_user.authorizations.empty?
      redirect_to new_request_form_path
    end

    meter = policy_scope(Meter).first
    if meter
      @bills = meter.bills&.statement_period_between(Time.zone.local(2024, 4, 1), Time.zone.local(2024, 7, 1)).preload(:line_items)
      @readings = meter.readings&.occurred_between(Time.zone.local(2024, 6, 1), Time.zone.local(2024, 7, 1))
      render(locals: { bills: @bills, readings: @readings, user: current_user })
    end
  end
end