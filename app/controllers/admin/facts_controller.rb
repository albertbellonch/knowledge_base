class Admin::FactsController < Admin::AdminController
  def index
    @facts = Fact.all
    @categories = Category.all
  end

  def update
    @fact = Fact.find_by_title_url!(params[:id])
    @fact.update_attributes(params[:fact])

    respond_to do |format|
      format.html { redirect_to admin_categories_path }
      format.json { head :ok }
    end
  end

  def destroy
    @fact = Fact.find_by_title_url!(params[:id])
    @fact.destroy
    redirect_to admin_facts_path
  end
end
