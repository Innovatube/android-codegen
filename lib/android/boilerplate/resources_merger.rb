require_relative 'mergeable'

##
#Class' description
#
#@author::          Ethan Le
#@usage::           An implementation of Mergeable to merge resources file
#@revision::        date of the 20/3/2017
#@todo::            untested, create an universal resources merge
#@fixme::
##
module AndroidBoilerplate
  class ResourcesMerger
    include Mergeable

    # Get/Set the resource type
    # Example: string, dimen, integer
    attr_accessor :resources_type

    # initialize
    # options : The hash contains attribute (input and output location...)
    # resources_type: resources type to be merger (for testing purpose)
    def initialize(options, resources_type)
      super(options)
      self.resources_type = resources_type
      self.name_regex = /(?<=#{resources_type}\sname=").+(?=")/
      self.holder_regex = /(?<=<resources>.)(.+)(?=<\/resources>)/m
      self.resource_regex = /(?<!>)\s+<#{resources_type}.+/
    end

    # Merge a single resource to target
    # item   :  a single resource to be merged
    # target :  a target file
    def merge(item, target)
      target.gsub!( /(?<=<resources>.)(.+)(?=<\/resources>)/m,"\\1#{item}")
      target.gsub!(/<\/resources>/,"\n</resources>")
    end
  end
end