class Pokemon::Import
  include ActiveModel::Model

  attr_accessor :file, :imported_count

  def process!
    return unless file.present?
    @imported_count = 0

    ::CSV.foreach(file.path, headers: true, header_converters: :symbol) do |line|
      pokemon = Pokemon.assign_from_line_items(line)
      if pokemon.save
        @imported_count += 1
      else
        errors.add(:base, "line #{$.} - #{pokemon.errors.full_messages.join(', ')}")
      end
    end
  end

  def save
    process!
    errors.none?
  end
end
