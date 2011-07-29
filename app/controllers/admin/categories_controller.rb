class Admin::CategoriesController < Admin::AdminController
  def index
    @categories = Category.all
    @uncategorized_count = Fact.where(:category_id => nil).count
  end

  def create
    @category = Category.new(params[:category])
    @category.save
    redirect_to admin_categories_path
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])

    respond_to do |format|
      format.html { redirect_to admin_categories_path }
      format.json { head :ok }
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end
end
