module Pokemons
  class RemoveWorker
    include Sidekiq::Worker
    sidekiq_options retry: false, queue: 'default'

    def perform(params)
      return if params.empty?
      ids = params['ids']
      Pokemon.where(id: ids).destroy_all
      # ids.nil? ? Pokemon.destroy_all : Pokemon.where(id: ids).destroy_all
    end
  end
end
