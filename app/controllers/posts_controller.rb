class PostsController < ApplicationController
  
  before_action :set_post

  def show
    
  end

  private

  def set_post
    @post = Post.find_by_uuid(params[:id])
    
    rendered_content = CommonMarker.render_doc(@post.content, :DEFAULT)
    @markdown = rendered_content.to_html
  end
  
end
