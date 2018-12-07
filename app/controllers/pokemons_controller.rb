class PokemonsController < ApplicationController
  before_action :pokemons, only: %I(index import export)
  before_action :import_object, only: %I(index import export remove_all)

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

  def export
    PokemonExportWorker.perform_async(current_user&.email)
    flash[:info] = 'Check email and download dump Pokemons'
    render action: :index
  end

  def remove_all
    PokemonRemoveWorker.perform_async
    flash[:info] = 'All pokemons info will be remove'
    render action: :index
  end

  private

    def pokemons
      @items = Pokemon.all.order(:identifier)
    end

    def import_object
      @import = params[:pokemon_import].present? ? Pokemon::Import.new(pokemons_import_params) : Pokemon::Import.new
    end

    def pokemons_import_params
      params.require(:pokemon_import).permit(:file)
    end
end
