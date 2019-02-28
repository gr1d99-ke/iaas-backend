Rails.application.routes.draw do
  resource :users, only: :create
  resource :sessions, only: :create
  resource :openings, only: :create
end
