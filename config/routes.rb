Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html
  post "/log_out", to: "account#log_out"
  get  "/log_out", to: "account#log_out"
  post "/generate_account", to: "account#create"
  get  "/generate_account", to: "account#create"
  get  "/error", to: "account#error"

  root "account#index"
end
