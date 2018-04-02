class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    post_body = {
      client_id: ENV['ID'],
      client_secret: ENV['SECRET'],
      redirect_uri: "http://localhost:3000/auth",
      code: params[:code]
    }

    url = "https://github.com/login/oauth/access_token"

    resp = Faraday.post(url, post_body)

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
