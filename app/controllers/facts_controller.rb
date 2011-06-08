class FactsController < ApplicationController
  load_and_authorize_resource

  def index
    # Search params
    @is_search = params[:search]

    # Get base
    if @is_search
      @total = Fact.search(params[:search], :order => :created_at, :sort_mode => :desc, :include => [:user,:comments,:tags])
    else
      @tag = params[:tag]
      @base = Fact.includes(:user,:comments,:tags)
      @total = @tag.present? ? @base.for_tag(@tag) : @base.all
    end

    # And paginate!
    @page = params[:page] || 1
    @facts = @total.paginate :page => @page, :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facts }
    end
  end

  def show
    @fact = Fact.includes(:user,[:comments => :user]).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fact }
    end
  end

  def new
    @fact = Fact.new
    @tags = Tag.includes(:fact_tags)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fact }
    end
  end

  def create
    @fact = Fact.new(params[:fact])
    @fact.user = current_user
    @tags = Tag.all

    if @fact.save
      redirect_to(facts_path, :notice => "L'entrada ha estat creada satisfactòriament")
    else
      flash[:alert] = "Assegura't d'introduir el títol i el text abans de crear l'entrada, siusplau"
      render :action => "new"
    end
  end

  def edit
    @fact = Fact.includes(:tags).find(params[:id])
    @tags = Tag.all

    unless @fact.user == current_user
      redirect_to(facts_path, :alert => "No pots editar una entrada que no sigui teva")
    end
  end

  def update
    @fact = Fact.find(params[:id])

    unless @fact.user == current_user
      redirect_to(facts_path, :alert => "No pots editar una entrada que no sigui teva")
    end

    if @fact.update_attributes(params[:fact])
      redirect_to(facts_path, :notice => "L'entrada ha estat actualitzada satisfactòriament")
    else
      flash[:alert] = "Assegura't d'introduir el títol i el text abans d'actualitzar l'entrada, siusplau"
      render :action => "edit"
    end
  end

  def destroy
    @fact = Fact.find(params[:id])
    if @fact.user == current_user
      @fact.destroy
      flash[:notice] = "L'entrada s'ha eliminat satisfactòriament"
    else
      flash[:alert] = "No pots eliminar una entrada que no sigui teva"
    end

    redirect_to facts_path
  end
end
