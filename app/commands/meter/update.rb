# frozen_string_literal: true

module Meter::Update
  class << self
    def call(meter)
      meter = Meter.find_by(external_uid: meter[:uid])
    end
  end
end