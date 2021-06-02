class PostsController < ApplicationController 
  before_action :set_post, only: [:edit, :update, :show, :destroy]


  def index
    @tenant_name = ActsAsTenant.current_tenant.name 
    p (ActsAsTenant.current_tenant)
    @posts = Post.all 
  end

  private 
  def set_post 
    Post.find_by(id: params[:id])
  end
end