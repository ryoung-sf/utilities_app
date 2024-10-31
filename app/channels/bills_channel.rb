class BillsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bills"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
  end
end
