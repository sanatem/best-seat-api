Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    scope '(v:version)', format: false, defaults: { format: :json, version: 1 }, constraints: { version: /[1]/ } do
      resources :venues, only: %i[index show create] do
        post :import, on: :collection
        post :select_seat, on: :member
        get  :best_seat, on: :member
      end
    end
  end
end
