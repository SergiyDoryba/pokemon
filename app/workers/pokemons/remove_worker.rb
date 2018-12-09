module Pokemons
  class RemoveWorker
    include Sidekiq::Worker
    sidekiq_options retry: false, queue: 'default'

    def perform(params)
      if !params.key?('ids')
        Pokemon.destroy_all
      else
        return if params['ids'].nil?
        ids = params['ids']
        Pokemon.where(id: ids).destroy_all
      end
    end
  end
end
