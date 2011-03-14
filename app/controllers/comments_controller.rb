class CommentsController < ApplicationController

  # POST /facts/:fact_id/comments
  def create
    @comment = Comment.new(params[:comment])
    @fact = Fact.find(params[:fact_id])
    @comment.fact = @fact
    @comment.user = current_user

    if @comment.save
      redirect_to(@fact)
    else
      redirect_to(@fact)
    end
  end

end
