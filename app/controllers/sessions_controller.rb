class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  require 'json'

  def create
    post_body = {
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET'],
      redirect_uri: "http://localhost:3000/auth",
      code: params[:code]
    }

    url = "https://github.com/login/oauth/access_token"

    resp = Faraday.post do |req|
      req.url url
      req.body = post_body
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
