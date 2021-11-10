class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authorize

  def index
    byebug
    articles = Article.all
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  def authorize
    return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
  end

end
