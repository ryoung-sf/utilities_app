# frozen_string_literal: true

require 'factory_bot'

module FactoryCache
  def self.user
    @user ||= FactoryBot.create(:user)
    @user.confirm
    @user
  end

  def self.authorization
    @authorization ||= FactoryBot.create(:authorization)
  end

  def self.reset
    @user = nil
    @authorization = nil
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.after do
    FactoryBot.rewind_sequences
    FactoryCache.reset
  end
end

module FactoryBot::Syntax::Methods
  def default_user
    FactoryCache.user
  end

  def default_authorization
    FactoryCache.authorization
  end
end