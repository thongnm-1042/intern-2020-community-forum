class FavoritesController < ApplicationController
  authorize_resource Post

  before_action :authenticate_user!
  before_action :find_user, :correct_user, only: :index

  def index
    @q = current_user.mark_posts.ransack params[:q].try(:merge, m: "or")
    @posts = @q.result.includes(:user, :topic, :tags)
               .order_mark_posts
  end
end
