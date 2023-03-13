Rails.application.routes.draw do

  root "main#index" #--> equal to   match "/" , to : "main#{index}" , via: get
  # match "task/index" , to : "main#{index}" , via: get
  # match "task/:id" , to : "tasks#{show}" , via: get
  get 'task/index'
  get 'task/new'
  get 'task/edit'
  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
