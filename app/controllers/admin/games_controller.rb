class Admin::GamesController < ApplicationController

  layout 'admin'
  before_action :authenticate_player!

  # GET /admin/games
  def index
    all = Game.order(id: :desc)
    @games = all.page params[:page]
    @stats = {
      count: all.count,
      new_count: all.where('created_at > ?', Date.today - 30.days).count,
    }
  end

  # GET /admin/games/new
  def new
    @game = Game.new
    @attrs = Admin::AttributeCollector.empty_attrs
  end

  # POST /admin/games
  def create
    @game = Game.new games_params

    if @game.save
      redirect_to admin_games_path, notice: t('game.create')  % { game: @game.name }
    else
      @attrs = Admin::AttributeCollector.from_params params
      render 'new'
    end
  end

  # GET /admin/games/:id/edit
  def edit
    @game = Game.find params[:id]
    @attrs = Admin::AttributeCollector.from_db params[:id]
  end

  # POST /admin/games/:id
  def update
    @game = Game.find params[:id]

    if @game.update games_params
      redirect_to admin_games_path, notice: t('game.update') % { game: @game.name }
    else
      @attrs = Admin::AttributeCollector.from_params params
      render 'edit'
    end
  end

  # DELETE /admin/games/:id
  def destroy
    @game = Game.find params[:id]
    @game.destroy

    redirect_to admin_games_path, notice: t('game.destroy')  % { game: @game.name }
  end

  private

  def games_params
    params.require(:game).permit(
      :played_on, :venue_id, :season_id,
      games_players_attributes: [:id, :player_id, :position, :_destroy],
      referees_attributes: [:id, :player_id, :_destroy]
    )
  end

end