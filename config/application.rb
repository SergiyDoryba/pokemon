require_relative 'boot'
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PokemonBeckSide
  class Application < Rails::Application
    config.application_name = Rails.application.class.parent_name

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.eager_load_paths << Rails.root.join('app', 'workers')
    # config.eager_load_paths << Rails.root.join('app', 'services')
    config.autoload_paths += [config.root.join('app')]
    # config.autoload_paths += %W(#{config.root}/app/workers)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.hidden_namespaces << :test_unit << :erb
      g.test_framework  :rspec, fixture: false
      g.orm             :active_record
      g.template_engine :haml
      g.stylesheets     false
      g.javascripts     false
    end
  end
end
