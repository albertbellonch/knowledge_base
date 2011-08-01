class FactsController < ApplicationController
  autocomplete :tag, :name, :full => true

  before_filter :show_find, :only => :show
  before_filter :edit_find, :only => :edit
  load_resource :find_by => :title_url
  authorize_resource

  def index
    # Search params
    @is_search = params[:search]

    if @is_search
      # Search directly
      @total = Fact.search(params[:search], :order => :created_at, :sort_mode => :desc, :include => [:user,:comments,:tags,:category])
    else
      # Get base
      @base = Fact.includes(:user,:comments,:tags,:category)
      @base = @base.for_categories(current_user.categories) if user_signed_in?

      # Get total
      if @tag = params[:tag]
        @total = @base.for_tag(@tag)
      elsif @user = params[:user]
        @total = @base.for_user(@user)
      else
        @total = @base.all
      end
    end

    # And paginate!
    @page = params[:page].to_i
    @page = 1 if @page == 0
    @facts = @total.paginate :page => @page, :per_page => 10
  end

  def show
  end

  def new
    @fact = Fact.new
    @tags = Tag.includes(:fact_tags)
    @categories = Category.all
  end

  def create
    @fact = Fact.new(params[:fact])
    @fact.user = current_user

    if @fact.save
      @fact.reload
      redirect_to(root_path, :notice => "L'entrada ha estat creada satisfactòriament")
    else
      @tags = Tag.all
      @categories = Category.all
      flash[:alert] = "Assegura't d'introduir el títol (ha de ser únic!) i el text abans de crear l'entrada, siusplau"
      render :action => "new"
    end
  end

  def edit
    @tags = Tag.all
    @categories = Category.all
  end

  def update
    @fact = Fact.find_by_title_url!(params[:id])

    if @fact.update_attributes(params[:fact])
      redirect_to(root_path, :notice => "L'entrada ha estat actualitzada satisfactòriament")
    else
      @tags = Tag.all
      @categories = Category.all
      flash[:alert] = "Assegura't d'introduir el títol i el text abans d'actualitzar l'entrada, siusplau"
      render :action => "edit"
    end
  end

  def destroy
    @fact = Fact.find_by_title_url!(params[:id])
    if @fact.destroy
      flash[:notice] = "L'entrada s'ha eliminat satisfactòriament"
    else
      flash[:alert] = "No pots eliminar una entrada que no sigui teva"
    end

    redirect_to root_path
  end

  private

  def show_find
    @fact = Fact.includes(:user,[:comments => [:user,:fact]]).find_by_title_url!(params[:id])
  end

  def edit_find
    @fact = Fact.includes(:fact_tags).find_by_title_url!(params[:id])
  end
end
