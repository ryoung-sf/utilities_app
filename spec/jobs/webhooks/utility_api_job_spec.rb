require 'rails_helper'

RSpec.describe Webhooks::UtilityApiJob, type: :job do
  it "enqueues a job" do
    webhook = create(:inbound_webhook)
    
    expect {
      described_class.perform_later(webhook)
    }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
  
  it "executes perform" do
    webhook = create(:inbound_webhook)
    json = JSON.parse(webhook.body, symbolize_names: true)
    first_event = json[:events].first

    expect(Webhook::ProcessAuthorization).to receive(:call).with(first_event)
    perform_enqueued_jobs { described_class.perform_later(webhook) }
    
    expect(webhook.reload.status).to eq("processed")
  end
end
