class Pokemon < ApplicationRecord
  include Storext.model
  validates :identifier, presence: true

  store_attributes :parsed_data do
    wikipedia_en String
    wikipedia_ua String
    wikipedia_ru String
  end

  def self.need_fetch_data_from_off_site
    last(10)
  end

  def self.assign_from_line_items(line)
    pokemon = Pokemon.where(identifier: line[:identifier]).first_or_initialize
    pokemon.assign_attributes(line.to_hash.slice(:species_id,
                                                 :height,
                                                 :weight,
                                                 :base_experience,
                                                 :order,
                                                 :is_default
    ))
    pokemon
  end

  def self.to_csv
    attributes = %W(id identifier species_id height weight base_experience order is_default created_at)

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |pokemon|
        csv << pokemon.attributes.values_at(*attributes)
      end
    end
  end
end
