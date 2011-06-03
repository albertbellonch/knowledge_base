class CommentsController < ApplicationController

  # POST /facts/:fact_id/comments
  def create
    @comment = Comment.new(params[:comment])
    @fact = Fact.find(params[:fact_id])
    @comment.fact = @fact
    @comment.user = current_user

    flash[:notice] = "Gràcies per comentar!"

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @fact }
        format.js
      else
        redirect_to(@fact)
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
    end

    respond_to do |format|
      format.html { redirect_to @comment.fact }
      format.js
    end
  end

end
