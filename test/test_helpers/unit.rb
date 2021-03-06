require "minitest/hooks/test"
require_relative "database"
require_relative "factory"
require_relative "elastic"
require_relative "upload"
require_relative "email"
require_relative "profiling"
require_relative "assertions"

module TestHelpers
  module Unit
    def self.included(klass)
      klass.include Minitest::Hooks

      klass.include TestHelpers::Database,
                    TestHelpers::Factory,
                    TestHelpers::Elastic,
                    TestHelpers::Upload,
                    TestHelpers::Email,
                    TestHelpers::Profiling,
                    TestHelpers::Assertions
    end
  end
end
