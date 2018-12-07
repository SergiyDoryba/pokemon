class PokemonRemoveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'default'

  def perform
    Pokemon.destroy_all
  end
end
