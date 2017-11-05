Rails.application.routes.draw do
  resources :notes
  get '/messages/:id/info', to: 'messages#info'
  post '/messages/api', to: 'messages#create'
end
