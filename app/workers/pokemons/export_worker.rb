module Pokemons
  class ExportWorker
    include Sidekiq::Worker
    sidekiq_options retry: false, queue: 'default'

    attr_accessor :file, :imported_count

    def perform(user_email)
      Rails.logger.info 'User Mail at Worker'
      Rails.logger.info user_email
      pokemons = Pokemon.all.select(:id)
      if pokemons.count > 0
        Rails.logger.info 'Generate CSV file'
        Pokemon::Export.new(user_email: user_email, xls_format: true).process!
        Rails.logger.info 'Sent Email with attachment link'
        ExportMailer.export_data(user_email).deliver_now
      end
    end
  end
end
