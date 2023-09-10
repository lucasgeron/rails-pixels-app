class PixelsController < ApplicationController
  def index
    @pixels = Pixel.all
  end

  def reset
    Pixel.update_all(color:'default')
    redirect_to root_path
  end

  def colorize
    Pixel.all.each do |pixel|
      pixel.update(color: Pixel::COLORS.sample)
    end
    redirect_to root_path
  end

  def colorize_job
    ColorizePixelsJob.perform_later
  end

end
