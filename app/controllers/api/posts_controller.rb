module Api
  class PostsController < ApplicationController

    before_action :set_post
    before_action :check_token, only: [:update, :destroy]
    skip_before_action :verify_authenticity_token

    def show
      render json: @post.to_json(:except => [:token, :id, :uuid])
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        render json: @post.to_json(:except => [:id]), status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
        render json: @post.to_json(:except => [:id]), status: :ok
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      head :no_content
    end

    private

    def set_post
      @post = Post.find_by_uuid(params[:id])
    end

    def check_token
      if @post&.token != params[:token]
        render json: {error: 'Access denied'}, status: 401
        return
      end
    end

    def post_params
      params.require(:post).permit(:content)
    end

  end
end