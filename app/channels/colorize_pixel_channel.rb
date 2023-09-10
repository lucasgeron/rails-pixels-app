class ColorizePixelChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ColorizePixelChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
