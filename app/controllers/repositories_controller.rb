class RepositoriesController < ApplicationController
  require 'json'
  def index
    resp = Faraday.get do |req|
      req.url 'https://api.github.com/user/repos'
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    @body = JSON.parse(resp.body)
  end

  def create
    redirect_back if params[:name].empty?

    resp = Faraday.post do |req|
      req.url 'https://api.github.com/user/repos'
      req.body = {name: params[:name]}.to_json
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)

    flash[:message] = "Created #{ body['name'] } at #{ body['html_url'] }"
    redirect_to root_path
  end
end
