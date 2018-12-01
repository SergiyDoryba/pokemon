class PokemonsController < ApplicationController
  before_action :pokemons, only: %I(index import)
  before_action :import_object, only: %I(index import)

  def index; end

  def import
    if !params[:pokemon_import].present?
      flash[:warning] = "Please select file to import Data"
      render action: :index
    elsif @import.save
      flash[:success] = "Imported count: #{@import.imported_count} Pokemons!"
      render action: :index
    else
      flash[:danger] = "There are errors CSV File"
      render action: :index
    end
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
