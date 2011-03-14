class CommentsController < ApplicationController

  # POST /facts/:fact_id/comments
  def create
    @comment = Comment.new(params[:comment])
    @fact = Fact.find(params[:fact_id])
    @comment.fact = @fact
    @comment.user = current_user

    flash[:notice] = "Thanks for commenting"

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @fact }
        format.js
      else
        redirect_to(@fact)
      end
    end
  end

end
