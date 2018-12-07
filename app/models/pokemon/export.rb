class Pokemon::Export
  include ActiveModel::Model

  attr_accessor :user_email, :xls_format, :pokemons, :export_dir

  def process!
    generate_xls if xls_format
  end


  def generate_xls
    Xlsxtream::Workbook.open("#{folder_path}/pokemons.xls") do |xlsx|
      xlsx.write_worksheet 'default-Pokemons' do |sheet|
        sheet << ['#', 'Identifier', 'height', 'weight']
        pokemons.map do |pokemon|
          sheet << [pokemon.id.to_s, pokemon&.identifier, pokemon&.height, pokemon&.weight]
        end
      end
    end
  end

  private

    def folder_path
      @export_dir = Rails.root.join('public', 'exports', @user_email, DateTime.now.in_time_zone.strftime('%Y_%m_%d')).to_s
      mkdir_p(export_dir) unless File.exists?(export_dir)
      export_dir
    end

    def pokemons
      @pokemomns = Pokemon.all
    end
end
