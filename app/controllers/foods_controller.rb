class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  # GET /foods
  # GET /foods.json
  def index
    min_max_array = params[:decade].split(',')
    @min = min_max_array[0]
    @max = min_max_array[1]
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
  end

  def local_menu_search
    @name = params[:name]
    @local_search = HTTParty.get("http://api.locu.com/v1_0/menu_item/search/?api_key=6aa048a34d1b96643052e2b69318afddb0b53b21&name=#{@name}")
    @local_lat = @local_search['objects'][0]['venue']['lat']
    @local_lon = @local_search['objects'][0]['venue']['long']
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render action: 'show', status: :created, location: @food }
      else
        format.html { render action: 'new' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:dish, :year, :qty)
    end
end
