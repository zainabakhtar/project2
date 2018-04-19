Rails.application.routes.draw do
  resources :registrations
  resources :users
  resources :students
  resources :families
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :camp_instructors
  resources :camps
  resources :curriculums
  resources :locations
  resources :instructors

  get 'home', :to => "home#index"
   root :to => "home#index"
   
   get 'about', :to => "about#index"
   root :to => "about#index"
   
   get 'contact', :to => "contact#index"
   root :to => "contact#index"
   
     get 'privacy', :to => "privacy#index"
   root :to => "privacy#index"
   
end
