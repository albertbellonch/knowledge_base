class StaticController < ApplicationController
  def index
  end

  def feed
    @facts = Fact.includes(:user).all

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
