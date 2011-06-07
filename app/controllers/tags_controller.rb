class TagsController < ApplicationController
  def create
    @tag = Tag.new params[:tag]

    respond_to do |format|
      if @tag.save
        format.js { render :layout => false }
      else
        format.json  { render :json => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag = Tag.includes(:fact_tags).find params[:id]
    @tag.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end
end
