class RepositoriesController < ApplicationController
  def index
    @username = session[:username]
  end

  def create
  end
end
