Rails.application.routes.draw do
  resource :users, only: :create
  resource :sessions, only: :create
  resources :openings, only: [:index, :create, :show, :update, :destroy]
  mount CoverLetterUploader.upload_endpoint(:cache) => "applications/cover-letter/upload"
  mount ResumeUploader.upload_endpoint(:cache) => "applications/resume/upload"
end
