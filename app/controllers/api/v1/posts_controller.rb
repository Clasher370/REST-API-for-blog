class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.all
    json_response(@posts)
  end

  def show
  end

  def create
  end
end
