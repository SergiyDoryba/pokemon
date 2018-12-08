module Services
  module Pokemons
    module Offsite
      class FetchData < Services::Base
        OFFSITE_URL = 'https://www.pokemon.com/us/pokedex'.freeze

        attr_reader :identifier

        attr_accessor :link_to_request, :request_data, :response_data, :weaknesses

        def initialize(**args)
          raise ArgumentError.new('Pokemons FetchData Service [identifier] must be exists') unless args[:identifier].present?
          @identifier = args[:identifier]
          @link_to_request = OFFSITE_URL + '/' + identifier
        end

        def call
          Rails.logger.info identifier
          Rails.logger.info '*-------*'
        end

        private


          def weaknesses
            @weaknesses = response_data.xpath('//dtm-weaknesses/ul')
          end

          def request_data
            @request_data = RestClient.get(link_to_request)
          end

          def response_data
            @response_data = Nokogiri::XML(request_data.body)
          end
      end
    end
  end
end
