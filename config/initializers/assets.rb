# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( registrations.scss )
Rails.application.config.assets.precompile += %w( departments.scss )
Rails.application.config.assets.precompile += %w( divisions.scss)
Rails.application.config.assets.precompile += %w( registrations.js.coffee )
Rails.application.config.assets.precompile += %w( departments.js.coffee )
Rails.application.config.assets.precompile += %w( divisions.js.coffee )
Rails.application.config.assets.precompile += %w( users.js.coffee )
Rails.application.config.assets.precompile += %w( users.scss )
Rails.application.config.assets.precompile += %w( areas.js.coffee )
Rails.application.config.assets.precompile += %w( areas.scss )
Rails.application.config.assets.precompile += %w( goals.js.coffee )
Rails.application.config.assets.precompile += %w( goals.scss )
Rails.application.config.assets.precompile += %w( plans.js.coffee )
Rails.application.config.assets.precompile += %w( plans.scss )
Rails.application.config.assets.precompile += %w( objectives.js.coffee )
Rails.application.config.assets.precompile += %w( objectives.scss )
Rails.application.config.assets.precompile += %w( strategies.js.coffee )