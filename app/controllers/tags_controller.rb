class TagsController < ApplicationController
  load_and_authorize_resource

  def create
    @tag = Tag.new params[:tag]

    respond_to do |format|
      @tag.save
      format.js { render :layout => false }
    end
  end

  def add
    respond_to do |format|
      if @tag = Tag.find_by_name(params[:name])
        format.js
      else
        format.json  { render :json => "not found", :status => :unprocessable_entity }
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
