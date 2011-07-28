class Admin::CategoriesController < Admin::AdminController
  def index
    @categories = Category.all
  end
end
