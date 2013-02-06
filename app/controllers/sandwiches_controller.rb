class SandwichesController < ApplicationController
  before_filter :set_user
  before_filter :get_order

  def get_order
    @order = Order.find(session[:order_id]) if session[:order_id]
    logger.debug "current order session: #{@order.id}" if @order
  end

  # GET /sandwiches
  # GET /sandwiches.json
  def index
    @sandwiches = Sandwich.where(order_id: @order.id) if @order
    @sandwiches ||= Sandwich.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sandwiches }
    end
  end

  # GET /sandwiches/1
  # GET /sandwiches/1.json
  def show
    @sandwich = Sandwich.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sandwich }
    end
  end

  def edit_session
    params.merge!(order_id: @order.id)
    @sandwich_examples = Sandwich.examples
    @containers = Container.order(:name)
    @ingredients = Ingredient.all
    @meats = @ingredients.select{|i| i.class == Meat}.sort{|a,b| a.name <=> b.name}
    @veggies = @ingredients.select{|i| i.class == Vegetable}.sort{|a,b| a.name <=> b.name}
    @cheeses = @ingredients.select{|i| i.class == Cheese}.sort{|a,b| a.name <=> b.name}
    @condiments = @ingredients.select{|i| i.class == Condiment}.sort{|a,b| a.name <=> b.name}
  end

  def select_theme
    @sandwich = Sandwich.themed(params)
    logger.debug "current sandwich: #{@sandwich.ingredients.inspect} on #{@sandwich.container.name}"
    edit_session
  end

  def copy_sandwich
    # new order started
    @order = if session[:order_id]
      Order.find(session[:order_id])
    else
      order = Order.create(user_id: @user.id)
      session[:order_id] = order.id
      order
    end

    @sandwich = Sandwich.copy(params[:id])
    @sandwich.order_id = @order.id
    logger.debug "current sandwich: #{@sandwich.ingredients.inspect} on #{@sandwich.container.name}"
    edit_session
    render :new
  end

  # GET /sandwiches/new
  # GET /sandwiches/new.json
  def new
    @sandwich = Sandwich.new
    edit_session

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sandwich }
    end
  end

  # GET /sandwiches/1/edit
  def edit
    @sandwich = Sandwich.find(params[:id])
    edit_session
  end

  # POST /sandwiches
  # POST /sandwiches.json
  def create
    params.merge!(order_id: @order.id)
    @sandwich = Sandwich.build_one(params)

    respond_to do |format|
      if @sandwich.save
        format.html { redirect_to :action => :index, notice: 'Sandwich was successfully created.' }
        format.json { render json: @sandwich, status: :created, location: @sandwich }
      else
        edit_session
        format.html { render action: "new" }
        format.json { render json: @sandwich.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sandwiches/1
  # PUT /sandwiches/1.json
  def update
    @sandwich = Sandwich.update_one(params)

    respond_to do |format|
      if @sandwich.save
        format.html { redirect_to @sandwich, notice: 'Sandwich was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sandwich.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sandwiches/1
  # DELETE /sandwiches/1.json
  def destroy
    @sandwich = Sandwich.find(params[:id])
    @sandwich.destroy

    respond_to do |format|
      format.html { redirect_to sandwiches_url }
      format.json { head :no_content }
    end
  end
end
