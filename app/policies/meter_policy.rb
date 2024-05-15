# frozen_string_literal: true

class MeterPolicy
  attr_reader :user, :meter

  def initializer(user, meter)
    @user = user
    @meter = meter
  end

  def show?
    user.meter.exists?(id: meter.id)
  end
end