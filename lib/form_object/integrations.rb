require 'form_object/integrations/base'
Dir[File.join(File.dirname(__FILE__), "integrations", "*.rb")].sort.each do |path|
  require "form_object/integrations/#{File.basename(path)}"
end

module FormObject
  class InvalidIntegration < RuntimeError
    def initialize( name )
      super "#{name.inspect} is invalid integration"
    end
  end

  module Integrations

    # Find integrations for for selected class
    #
    # == Examples:
    #    class User
    #    end
    #
    #    class ActiveRecordUser < ActiveRecord::Base
    #    end
    #
    #    FormObject::Integrations.match(User) # => nil
    #    FormObject::Integrations.match(ActiveRecordUser) # => FormObject::Integrations::ActiveRecord
    def self.match( klass )
      all.detect {|integration| integration.matches?(klass)}
    end

    # Find integration by name
    #
    # == Examples:
    #    
    #    FormObject::Integrations.find_by_name(:active_record) # => FormObject::Integrations::ActiveRecord
    def self.find_by_name( name )
      all.detect {|integration| integration.integration_name == name} || raise( InvalidIntegration.new(name) )
    end

    def self.all
      # ActiveModel should be last item
      constants = self.constants.map {|c| c.to_s}
                                .select {|c| c != 'ActiveModel'}
                                .sort <<          'ActiveModel'
      constants.map {|c| const_get(c)}
    end
  end
end
