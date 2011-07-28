class Admin::OverviewController < Admin::AdminController
  def index
    redirect_to admin_facts_path
  end
end
