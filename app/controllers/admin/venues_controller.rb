require 'flash_message'

class Admin::VenuesController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/venues
  def index
    if params.has_key? :query
      @venues = Venue.search params[:query], page: params[:page], per_page: 25
    else
      @venues = Venue.page params[:page]
    end
  end

  # GET /admin/venues/new
  def new
    @venue = Venue.new
  end

  # POST /admin/venues
  def create
    @venue = Venue.new venue_params

    if @venue.save
      flash[:success] = Struct::Flash.new t('admin.venue.create.title'), t('admin.venue.create.body') % {venue: @venue.name }
      redirect_to admin_venues_path
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
      flash[:success] = Struct::Flash.new t('admin.venue.update.title'), t('admin.venue.update.body') % {venue: @venue.name }
      redirect_to admin_venues_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/venues/:id
  def destroy
    @venue = Venue.friendly.find params[:id]
    @venue.destroy

    flash[:success] = Struct::Flash.new t('admin.venue.destroy.title'), t('admin.venue.destroy.body') % {venue: @venue.name }
    redirect_to admin_venues_path
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :region_id, :address_line_one, :address_line_two, :suburb, :post_code, :state, :website, :facebook, :phone_number, :image)
  end
end
