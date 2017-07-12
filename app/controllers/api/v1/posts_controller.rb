class Api::V1::PostsController < ApplicationController
  def index
    @posts = @current_user.posts
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @todo = current_user.posts.create!(post_params)
    json_response(@todo, :created)
  end

  private

  def post_params
    params.permit(:title, :body, :published_at)
  end
end
