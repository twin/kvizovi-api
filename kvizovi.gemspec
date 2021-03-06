Gem::Specification.new do |gem|
  gem.name          = "kvizovi"
  gem.version       = "0.0.1"

  gem.required_ruby_version = ">= 2.2.0"

  gem.summary       = "API for Kvizovi"
  gem.description   = "The API endpoint used internally by http://kvizovi.org"
  gem.homepage      = "https://github.com/twin/kvizovi"

  gem.authors       = ["Janko Marohnić"]
  gem.email         = ["janko.marohnic@gmail.com"]

  gem.files         = Dir["README.md", "lib/**/*"]
  gem.require_path  = "lib"


  # App
  gem.add_dependency "roda", "~> 2.5"
  gem.add_dependency "roda-symbolized_params"
  gem.add_dependency "puma", "~> 2.12"

  # JSON
  gem.add_dependency "yaks", "~> 0.11"

  # Database
  gem.add_dependency "sequel", "~> 4.24"
  gem.add_dependency "sequel_pg"
  gem.add_dependency "pg"
  gem.add_dependency "sequel_postgresql_triggers", "~> 1.0.8"
  gem.add_dependency "elasticsearch", "~> 1.0.12"

  # Images
  gem.add_dependency "refile", ">= 0.5.5"
  gem.add_dependency "refile-sequel"
  gem.add_dependency "refile-mini_magick", "~> 0.1"
  gem.add_dependency "mini_magick", "~> 4.2"
  gem.add_dependency "refile-s3", "~> 0.1"
  gem.add_dependency "aws-sdk", "~> 2.1"

  # Email
  gem.add_dependency "simple_mailer", "~> 1.3"

  # Utility
  gem.add_dependency "bcrypt", "~> 3.1"
  gem.add_dependency "unindent"
  gem.add_dependency "as-duration", "~> 0.1"
  gem.add_dependency "memoizable"
  gem.add_dependency "inflecto"
  gem.add_dependency "dotenv", "~> 2.0"

  # Legacy
  gem.add_dependency "activesupport"

  # Backgound jobs
  gem.add_dependency "sidekiq", "~> 3.4.1"

  # Testing
  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest", "~> 5.6"
  gem.add_development_dependency "minitest-hooks", "~> 1.2"
  gem.add_development_dependency "timecop"
  gem.add_development_dependency "rack-test"
end
