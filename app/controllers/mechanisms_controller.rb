class MechanismsController < ApplicationController
  before_action :set_mechanism, only: [:show, :edit, :update, :destroy]

  # GET /mechanisms
  # GET /mechanisms.json
  def index
    @mechanisms = Mechanism.all
    e = Excavator.new
    @note = Mechanism.descendants
  end

  # GET /mechanisms/1
  # GET /mechanisms/1.json
  def show
  end

  # GET /mechanisms/new
  def new
    @region = Region.find(params[:region_id])
    @mechanism = Mechanism.new
    e = Mechanism.new
    @typeMechanism = Mechanism.subclasses
    @note = @typeMechanism
  end

  # GET /mechanisms/1/edit
  def edit
  end

  # POST /mechanisms
  # POST /mechanisms.json
  def create
    @region = Region.find(params[:region_id])
    @mechanism = Mechanism.new(mechanism_params)

    respond_to do |format|
      if @mechanism.save
        format.html { redirect_to region_mechanism_path(@mechanism.Region, @mechanism.id), notice: 'Mechanism was successfully created.' }
        format.json { render :show, status: :created, location:  @mechanism }
      else
        format.html { render :new }
        format.json { render json: @mechanism.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mechanisms/1
  # PATCH/PUT /mechanisms/1.json
  def update
    respond_to do |format|
      if @mechanism.update(mechanism_params)
        format.html { redirect_to [@region, @mechanism], notice: 'Mechanism was successfully updated.' }
        format.json { render :show, status: :ok, location: [@region, @mechanism] }
      else
        format.html { render :edit }
        format.json { render json: @mechanism.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mechanisms/1
  # DELETE /mechanisms/1.json
  def destroy
    @mechanism.destroy
    respond_to do |format|
      format.html { redirect_to region_mechanisms_url, notice: 'Mechanism was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mechanism
      @region = Region.find(params[:region_id])
      @mechanism = Mechanism.find(params[:id])
      e = Excavator.new
      @typeMechanism = ObjectSpace.each_object(Class).to_a
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mechanism_params
      params.require(:mechanism).permit(:name, :rating, :image, :price, :Region_id, :type)
    end
end
