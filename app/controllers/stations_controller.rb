class StationsController < ApplicationController
  respond_to :html, :json
  
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(params[:id])
    respond_with(@station)
  end

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(params[:station])
    if @station.save
      redirect_to @station, :notice => "Successfully created station."
    else
      render :action => 'new'
    end
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update_attributes(params[:station])
      redirect_to @station, :notice  => "Successfully updated station."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    redirect_to stations_url, :notice => "Successfully destroyed station."
  end
end
