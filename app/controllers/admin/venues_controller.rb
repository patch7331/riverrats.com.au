class Admin::VenuesController < ApplicationController

  layout 'admin'
  before_action :authenticate_player!

  # GET /admin/venues
  def index
    @venues = Venue.order(:name).page params[:page]
  end

  # GET /admin/venues/new
  def new
    @venue = Venue.new
  end

  # POST /admin/venues
  def create
    @venue = Venue.new venue_params

    if @venue.save
      redirect_to admin_venues_path, notice: t('venue.create') % {venue: @venue.name }
    else
      render 'new'
    end
  end

  # GET /admin/venues/:id/edit
  def edit
    @venue = Venue.friendly.find params[:id]
  end

  # PATCH /admin/venues/:id
  def update
    @venue = Venue.friendly.find params[:id]

    if @venue.update venue_params
      redirect_to admin_venues_path, notice: t('venue.update') % {venue: @venue.name }
    else
      render 'edit'
    end
  end

  # DELETE /admin/venues/:id
  def destroy
    @venue = Venue.friendly.find params[:id]
    @venue.destroy

    redirect_to admin_venues_path, notice: t('venue.destroy') % {venue: @venue.name }
  end

  private

    def venue_params
      params.require(:venue).permit(:name, :region_id, :address, :suburb, :state)
    end

end