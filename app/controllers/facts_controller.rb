class FactsController < ApplicationController
  before_filter :show_find, :only => :show
  before_filter :edit_find, :only => :edit
  load_resource :find_by => :title_url
  authorize_resource

  def index
    # Search params
    @is_search = params[:search]

    if @is_search
      # Search directly
      @total = Fact.search(params[:search], :order => :created_at, :sort_mode => :desc, :include => [:user,:comments,:tags])
    else
      # Get base
      @base = Fact.includes(:user,:comments,:tags)

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
    @page = params[:page] || 1
    @facts = @total.paginate :page => @page, :per_page => 10
  end

  def show
  end

  def new
    @fact = Fact.new
    @tags = Tag.includes(:fact_tags)
  end

  def create
    @fact = Fact.new(params[:fact])
    @fact.user = current_user

    if @fact.save
      @fact.reload
      redirect_to(root_path, :notice => "L'entrada ha estat creada satisfactòriament")
    else
      @tags = Tag.all
      flash[:alert] = "Assegura't d'introduir el títol (ha de ser únic!) i el text abans de crear l'entrada, siusplau"
      render :action => "new"
    end
  end

  def edit
    @tags = Tag.all

    unless @fact.user == current_user
      redirect_to(root_path, :alert => "No pots editar una entrada que no sigui teva")
    end
  end

  def update
    @fact = Fact.find_by_title_url!(params[:id])

    unless @fact.user == current_user
      redirect_to(root_path, :alert => "No pots editar una entrada que no sigui teva")
    end

    if @fact.update_attributes(params[:fact])
      redirect_to(root_path, :notice => "L'entrada ha estat actualitzada satisfactòriament")
    else
      flash[:alert] = "Assegura't d'introduir el títol i el text abans d'actualitzar l'entrada, siusplau"
      render :action => "edit"
    end
  end

  def destroy
    @fact = Fact.find_by_title_url!(params[:id])
    if @fact.user == current_user
      @fact.destroy
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
