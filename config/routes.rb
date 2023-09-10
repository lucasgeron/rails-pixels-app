Rails.application.routes.draw do
  root "pixels#index"
  post 'pixels/reset'
  post 'pixels/colorize'
  post 'pixels/colorize_job'
end
