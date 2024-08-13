# frozen_string_literal: true

class MeterPolicy < ApplicationPolicy
  # attr_reader :user, :meter

  # def initializer(user, meter)
  #   @user = user
  #   @meter = meter
  # end

  def index?
    meter.user == user
  end
  
  def show?
    meter.user == user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end
end