require "rake/testtask"

import "tasks/legacy.rake"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

namespace :db do
  desc "Migrate the database (you can specify the version with `db:migrate[N]`)"
  task :migrate, [:version] do |task, args|
    version = args[:version] ? Integer(args[:version]) : nil
    migrate(version)
    dump_schema
  end

  desc "Undo all migrations"
  task :demigrate do
    migrate(0)
    dump_schema
  end

  desc "Undo all migrations and migrate again"
  task :remigrate do
    migrate(0)
    migrate
    dump_schema
  end

  def migrate(version = nil)
    databases.each do |db|
      Sequel.extension :migration
      Sequel::Migrator.apply(db, "db/migrations", version)
    end
  end

  def dump_schema
    unless ENV["RACK_ENV"] == "production"
      db = databases.first
      system "pg_dump #{db.opts[:database]} > db/schema.sql"
      db.extension :schema_dumper
      File.write("db/schema.rb", db.dump_schema_migration(same_db: true))
    end
  end

  def databases
    @databases ||= ["development", "test", "production"]
      .map { |env| get_database(env) }
      .compact
  end

  def get_database(env)
    ENV["RACK_ENV"] = env
    require "kvizovi/configuration/sequel"
    DB
  rescue Sequel::DatabaseConnectionError
  ensure
    Object.send(:remove_const, :DB) if Object.const_defined?(:DB)
    $LOADED_FEATURES.reject! { |path| path.include?("kvizovi/configuration/sequel") }
    ENV.delete("RACK_ENV")
  end
end

namespace :elastic do
  desc "Create Elaticsearch index and import the records"
  task :setup => [:create, :import]

  desc "Create the Elasticsearch index"
  task :create do
    require "kvizovi"
    Kvizovi::ElasticsearchIndex.create!
  end

  desc "Import all existing quizzes to Elasticsearch"
  task :import do
    require "kvizovi"
    Kvizovi::Models::Quiz.dataset.each_page(1000) do |quizzes|
      Kvizovi::ElasticsearchIndex[:quiz].index(quizzes)
    end
  end
end

desc "Start the console with app loaded, in sandbox mode"
task :console do
  ARGV.clear

  require "kvizovi"
  require "pry"
  require "logger"

  include Kvizovi::Models
  DB.logger = Logger.new(STDOUT)
  Pry.start
end
