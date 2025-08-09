require "securerandom"

class AccountController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :create,
    with: -> { redirect_to :error, alert: "Please wait 3 minutes to create another account." }

  def index
    if !cookies.key?("username") || !cookies.key?("password")
      redirect_to :generate_account
    end
  end

  def error
    unless flash[:alert]
      redirect_to :root
    end
  end

  def create
    username = SecureRandom.hex(32)
    password = SecureRandom.hex(32)
    cookies["username"] = username
    cookies["password"] = password
    user = User.new(user_identifier: username, user_password: password)
    user.save()
    redirect_to :root
  end

  def log_out
    cookies.delete "username"
    cookies.delete "password"
    redirect_to :generate_account
  end
end
