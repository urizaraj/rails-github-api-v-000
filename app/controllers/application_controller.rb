class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

  def authenticate_user
    return if logged_in?

    client_id = ENV['GITHUB_CLIENT_ID']
    redirect_uri = CGI.escape('http://localhost:3000/users/auth/github/callback')

    github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=repo%20user"

    redirect_to github_url
  end

  def logged_in?
    !!session[:token]
  end
end
