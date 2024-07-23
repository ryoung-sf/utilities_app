require 'rails_helper'

RSpec.describe "Webhooks::UtilityApis", type: :request do
  def setup
    # load the webhook data from JSON file
    file_path = Rails.root.join("spec", "support", "fixtures", "authorizations", "one_authorization.json")
    @webhook = JSON.parse(File.read(file_path))
  end


  describe "GET /create" do
    post webhooks_utility_api, params: @webhook
    # pending "add some examples (or delete) #{__FILE__}"
  end
end
