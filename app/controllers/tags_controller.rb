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
    @tag = Tag.find params[:id]
    @tag.destroy

    respond_to do |format|
      format.js { head :ok }
    end
  end
end
