require "kvizovi/finders/gameplay_finder"
require "kvizovi/mediators/gameplays/create"
require "kvizovi/mediators/gameplays/validate"

module Kvizovi
  module Mediators
    class Gameplays
      PERMITTED_FIELDS = [
        :quiz_snapshot, :answers, :quiz_id, :player_ids,
        :started_at, :finished_at
      ]

      def self.create(attrs)
        Create.call(attrs)
      end

      def self.validate(gameplay)
        Validate.call(gameplay)
      end

      def initialize(user)
        @user = user
      end

      def search(**options)
        Finders::GameplayFinder.search(**options, user: @user)
      end

      def find(id)
        Finders::GameplayFinder.find(id)
      end

      def destroy_all
        @user.gameplays_dataset.delete
      end
    end
  end
end
