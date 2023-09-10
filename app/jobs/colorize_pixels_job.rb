class ColorizePixelsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    pixels = Pixel.all
    pixels = pixels.shuffle
    total = pixels.count
    pixels.each_with_index do |pixel, index|
      pixel.update(color: Pixel::COLORS.sample)
      ActionCable.server.broadcast('ColorizePixelChannel', { pixel: pixel, index: index+1, total: total } )
      sleep 0.1
    end
    ActionCable.server.broadcast('ColorizePixelChannel', { command: 'disconnect' } )
  end
end
