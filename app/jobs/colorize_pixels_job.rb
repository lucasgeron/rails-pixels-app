class ColorizePixelsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    pixels = Pixel.all
    pixels = pixels.shuffle
    total = pixels.count
    
    pixels.each_with_index do |pixel, index|
      pixel.update(color: Pixel::COLORS.sample)
      # update one pixel at a time
      Turbo::StreamsChannel.broadcast_update_to('pixels', target: "pixel_#{pixel.id}", partial: 'pixels/pixel', locals: { pixel: pixel })
      # update btn-job
      # Turbo::StreamsChannel.broadcast_replace_to('pixels', target: "btn-job", partial: 'pixels/btn_job', locals: { btn_text: "Colorizing: #{index+1} / #{total}", btn_class:' btn-primary bg-blue-600 text-white pointer-events-none' })
      # update pixels based on a selector
      Turbo::StreamsChannel.broadcast_update_to('pixels', targets: ".pixel_#{pixel.id}", partial: 'pixels/pixel', locals: { pixel: pixel })
    end
    Turbo::StreamsChannel.broadcast_replace_to('pixels', target: "btn-job", partial: 'pixels/btn_job')
  end
end
