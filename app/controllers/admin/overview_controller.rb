class Admin::OverviewController < Admin::AdminController
  def index
    redirect_to admin_categories_path
  end
end
