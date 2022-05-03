require_relative 'boot'

require 'rails/all'
require 'dotenv-rails'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Trummi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_cable.mount_path = '/cable'
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
	  # html_tag
      html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
      html = html.at_css("input") || html.at_css("select") || html.at_css("textarea")
      unless html.nil?
        css_class = html['class'] || "" 
        html['class'] = css_class.split.push("is-invalid").join(' ')
        html_tag = html.to_s.html_safe
      end
      html_tag
  	}
  end
end
