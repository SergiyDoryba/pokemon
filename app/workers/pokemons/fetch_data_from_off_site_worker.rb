module Pokemons
  class FetchDataFromOffSiteWorker
    include Sidekiq::Worker
    sidekiq_options retry: false, queue: 'default'


    def perform(pokemon_ids)
      pokemons = Pokemon.where(id: pokemon_ids)
      Rails.logger.info 'Run Workers to fetch data from Off site'
      Rails.logger.info "------ #{DateTime.now.in_time_zone} ------"
      pokemons.each do |pokemon|
        ::Services::Pokemons::Offsite::FetchData.new(identifier: pokemon.identifier).call
      end
    end
  end
end
