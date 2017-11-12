require 'json'

class RegionsController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update, :destroy]

  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(region_params)

    respond_to do |format|
      if @region.save
        format.html { redirect_to @region, notice: 'Region was successfully created.' }
        format.json { render :show, status: :created, location: @region }
      else
        format.html { render :new }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to @region, notice: 'Region was successfully updated.' }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region.destroy
    respond_to do |format|
      format.html { redirect_to regions_url, notice: 'Region was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #загрузка регионов из о json в бд
  def bootRegions
    #TODO Добавть что могут делать только админы, когда будут пользователи

    #Получаем хеш регионов с номерами регионов
    data = File.read('lib/jsondb/russia.subjects.json', encoding: 'utf-8')
    @hash_regions = JSON.parse(data)

    # Вылавливаем данные из хеша
    @out_regions = {}
    @hash_regions['data'].each do |hash|
      @out_regions[hash['regioncode']] = hash['name']
    end
    #Сортируем по возрастанию номер региона
    @out_regions = @out_regions.sort_by { |regioncode,name| regioncode}

    if (!Region.exists?(1))
      @out_regions.each do |key, name_region|
        Region.create(name: name_region)
      end
      @boot_message = "Данные в базу загружены"
    else
      @boot_message = 'Данные не загружены, в базе уже что-то есть, очистить бд: rake db:drop db:create db:migrate'
    end



  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_region
    @region = Region.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def region_params
    params.require(:region).permit(:name, :type)
  end


end
