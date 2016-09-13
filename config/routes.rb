Rails.application.routes.draw do

  get '/' => redirect("/university")

  namespace :university do
    root :to => 'universities#index'
  end
end
