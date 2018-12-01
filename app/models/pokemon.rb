class Pokemon < ApplicationRecord
  validates :identifier, presence: true

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

  def self.import(file_path)
    counter = 0
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |line|
      pokemon = Pokemon.assign_from_line_items(line)
      if pokemon.save
        counter += 1
      else
        puts "#{pokemon.identifier} - #{pokemon.errors.full_messages.join(', ')}"
      end
    end

    counter
  end

end
