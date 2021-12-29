Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "application#cookie"
  post "/add-to-cart", to: "carts#add_to_cart"
  get "/show-cart", to: "carts#show_cart"
  post "/remove-from-cart", to: "carts#remove_from_cart"

  # ! edit to post before deployement
  get "/clear-cart", to: "carts#clear_cart"

  post "/checkout", to: "carts#checkout"

  post "/purchase", to: "purchases#purchase"
end
