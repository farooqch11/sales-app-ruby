Rails.application.config.assets.precompile += %w( base.css base.js main.css)
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/