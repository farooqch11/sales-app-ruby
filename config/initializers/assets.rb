Rails.application.config.assets.precompile += %w( base.css base.js)
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/