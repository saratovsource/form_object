require "form_object/version"
require 'virtus'
require 'active_model'

module FormObject
  autoload :Utils,                  'form_object/utils'
  autoload :Base,                   'form_object/base'
  autoload :MappingInformation,     'form_object/base/mapping_information'
  autoload :Collection,             'form_object/base/collection'
  autoload :Store,                  'form_object/store'
  autoload :Dsl,                    'form_object/dsl'
  autoload :Integrations,           'form_object/integrations'
  # Your code goes here...
end
