Rails.application.routes.draw do
  post "/sign_in", to: "sign_in#create", as: :sign_in

  resource :users, only: :create
  resources :openings, only: [:index, :create, :show, :update, :destroy] do
    resources :applications, only: :create
  end

  mount CoverLetterUploader.upload_endpoint(:cache) => "applications/cover-letter/upload"
  mount ResumeUploader.upload_endpoint(:cache) => "applications/resume/upload"
end
