require_relative 'mergeable'

##
#Class' description
#
#@author::          Ethan Le
#@usage::           An implementation of Mergeable to merge AndroidManifest.xml
#@revision::        date of the 20/3/2017
#@todo::            untested, not fully working
#@fixme::
##

module AndroidBoilerplate
  class ManifestMerger
    include Mergeable

    # initialize
    # options  : The hash contains attributes to merge AndroidManifest.xml (input and output location...)
    def initialize(options)
      super(options)
      self.resource_regex = /<activity.*?>.*?\s*<\/activity>/m
      self.name_regex= /activity android:name="(.*?)"/
    end

    # Merge input_file to output_file
    def run
      input_file.scan(/#{resource_regex}/) do |item|
        unless (exist_in_target?(item, output_file))
          merge(item, output_file)
        else
          append_to_report(item)
        end
      end
      result = Hash.new
      result[:output_file] = output_file
      result[:report] = report
      return result
    end

    # Check if target file contain item or not
    # item    :   The activity to be tested
    # target  :   The manifest file to check if it contains item
    def exist_in_target?(item, target)
      item_name = extract_name(item)[0]
      !(target =~ /activity android:name="#{encode_string(item_name)}/).nil?
    end

    # Merge a single activity to target
    # item   :   a single activity to be merged
    # target :   a target file
    def merge(item, target)
      target.gsub!(/<application.*?>(.*?)<\/application>/m, "\\1#{item}")
    end
  end
end