class Api::V1::PostsController < ApplicationController
  after_action :set_headers, only: :index

  def index
    @posts = @current_user.posts.paginate(page: params[:page], per_page: params[:per_page])
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = current_user.posts.create!(post_params)
    json_response(@post, :created)
  end

  private

  def set_headers
    post_size = @current_user.posts.size
    pages_count = params[:per_page] ? (post_size / params[:per_page].to_i).to_s : 'none'

    response.set_header('Pages-Count', pages_count)
    response.set_header('Posts-Count', post_size.to_s)
  end

  def post_params
    params.permit(:title, :body, :published_at)
  end
end
