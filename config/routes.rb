Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


root to: "homes#top"
scope module: :public do
    resources :books, only: [:new, :index, :show, :edit, :create, :update] do
        resource :favorites, only: [:create, :destroy]
        resources :book_comments, only: [:create]

    end
    resources :users, omly: [:show, :edit, :update] do
      member do
        get :favorites
      end
    end
    get 'screens/screen'
    get 'searches/search'
    get 'screens/guest'

end

namespace :admin do
   resources :books do
     resources :comments, only: [:index]
    end
  get 'screens/screen'
  resources :users, only: [:index, :show]
end


 post '/homes/guest_sign_in', to: 'homes#new_guest'
end
