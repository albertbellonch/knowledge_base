class Admin::CategoriesController < Admin::AdminController
  def index
    @categories = Category.all
    @uncategorized_count = Fact.where(:category_id => nil).count
  end
end
