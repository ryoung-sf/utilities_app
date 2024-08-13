# frozen_string_literal: true

class AuthorizationPolicy < ApplicationPolicy
  attr_reader :user, :authorization

  def initialize(user, authorization)
    @user = user
    @authorization = authorization
  end

  def index?
    authorization.user == user
  end

  def show?
    authorization.user == user
  end

  def new?
    create?
  end

  def create?
    authorization.user == user
  end

  def update?
    create?
  end

  def destroy?
    authorization.user == user
  end
end