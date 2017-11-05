Rails.application.routes.draw do
  resources :messages
  get '/messages/:id/info', to: 'messages#info'
  post '/messages/api', to: 'messages#create'
end
