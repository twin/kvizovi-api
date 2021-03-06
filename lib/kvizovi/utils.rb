require "json"
require "inflection"
require "kvizovi/error"
require "kvizovi/uploaded_file"

module Kvizovi
  module Utils
    module_function

    def dump_json(data, env)
      if ENV["RACK_ENV"] == "production"
        JSON.generate(data)
      else
        JSON.pretty_generate(data)
      end
    end

    def resource(params, name)
      data = require_param(params, :data)
      attributes = data.fetch(:attributes)

      relationships = data.fetch(:relationships, {})
      relationships.each do |rel_name, value|
        if Hash === value[:data]
          id = value[:data][:id]
          attributes[:"#{rel_name}_id"] = id
        else
          ids = value[:data].map { |rel| rel[:id] }
          attributes.update(:"#{Inflection.singular(rel_name.to_s)}_ids" => ids)
        end
      end

      attributes
    end

    def require_param(params, name)
      params.fetch(name)
    rescue KeyError
      raise Kvizovi::Error::MissingParam, name
    end

    def valid!(object)
      if object.errors.any?
        errors = {}
        object.errors.each do |key, value|
          if key.is_a?(Symbol)
            errors[key] = value
          else
            errors[key.first] = value
          end
        end
        raise Kvizovi::Error::ValidationFailed, errors
      end
    end

    def mass_assign!(object, attrs, permitted_fields)
      object.set_only(attrs, *permitted_fields)
    rescue Sequel::MassAssignmentRestriction => error
      raise Kvizovi::Error::InvalidAttribute, error.message
    end

    def uploaded_file(hash, key)
      if hash[key].is_a?(Hash) && hash[key].key?(:tempfile)
        hash[key] = UploadedFile.new(hash[key])
      end
    end
  end
end
