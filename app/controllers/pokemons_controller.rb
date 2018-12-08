class PokemonsController < ApplicationController
  before_action :pokemons, only: %I(index import export fetch_data_pokemon_offsite)
  before_action :import_object, only: %I(index import export remove_all fetch_data_pokemon_offsite)

  def index; end

  def import
    if @import.save
      flash[:success] = "Imported count: #{@import.imported_count} Pokemons!"
      render action: :index
    else
      flash[:danger] = 'There are errors CSV File'
      render action: :index
    end
  end

  def fetch_data_pokemon_offsite
    Pokemons::FetchDataFromOffSiteWorker.perform_async(Pokemon.need_fetch_data_from_off_site.pluck(:id))
    flash[:info] = 'Run proccess to fetch data from Off Site for imported POkemons'
    render action: :index
  end

  def export
    Pokemons::ExportWorker.perform_async(current_user&.email)
    flash[:info] = 'Check email and download dump Pokemons'
    render action: :index
  end

  def remove_all
    Pokemons::RemoveWorker.perform_async({})
    flash[:info] = 'All pokemons info will be removed'
    render action: :index
  end


  def banch_destroy
    Pokemons::RemoveWorker.perform_async(ids: params[:ids])
    flash[:info] = 'Will be remove selected pokemons'
    respond_to do |format|
      format.json
    end
  end

  def banch_fetch_data_pokemon_offsite
    Pokemons::FetchDataFromOffSiteWorker.perform_async(params[:ids])
    flash[:info] = 'Run proccess to fetch data from Off Site for imported POkemons'
    respond_to do |format|
      format.json
    end
  end

  private

    def pokemons
      @items = Pokemon.all.order(order: :desc)
    end

    def import_object
      @import = params[:pokemon_import].present? ? Pokemon::Import.new(pokemons_import_params) : Pokemon::Import.new
    end

    def pokemons_import_params
      params.require(:pokemon_import).permit(:file)
    end
end
