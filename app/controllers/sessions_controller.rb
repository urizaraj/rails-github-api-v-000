class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  require 'json'

  def create
    post_body = {
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET'],
      redirect_uri: "http://localhost:3000/users/auth/github/callback",
      code: params[:code]
    }

    url = "https://github.com/login/oauth/access_token"

    resp = Faraday.post do |req|
      req.url url
      req.body = post_body.to_json
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    update_username
    redirect_to root_path
  end

  def update_username
    url = 'https://api.github.com/user'

    resp = Faraday.get do |req|
      req.url url
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:username] = body['login']
  end
end
