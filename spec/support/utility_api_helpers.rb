# frozen_string_literal: true

module UtilityApiHelpers
  def utility_api_stub(method: :get, path:, file:, query: {})
    stub_request(method, "https://utilityapi.com/api/v2/#{path}")
      .with(query: query)
      .to_return(
        status: 200,
        body: File.open(file),
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
        }
    )
  end

  def receive_params(**options)
    params = {
      include: "meters",
      referral: "1234",
      **options
    }
    params.to_query
  end
end