class MetersController < ApplicationController
  def index
    @meters = UtilityApi::Meters::Save.call("1591826")
    @bills = UtilityApi::Bills::Save.call( {meters: "1591826"})
    @intervals = UtilityApi::Intervals::Save.call( {meters: "1591826"})
  end
end
