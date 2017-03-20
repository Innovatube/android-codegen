##
#Class' description
#
#@author::          Ethan Le
#@usage::           An Utilities to check if command is available and check task condition
#@revision::        date of the 20/3/2017
#@todo::            untested
#@fixme::
##

module AndroidBoilerplate
  class Utilities
    class << self

      # Check if command is available in computer
      #  cmd - command to be tested
      #  Example
      #     command_available?('cat')
      #     # => true
      #     command_available?('not_exist')
      #     # => false
      def command_available?(cmd)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
        ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
          exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return true if File.executable?(exe) && !File.directory?(exe)
          }
        end
        return nil
      end

      # Check if task is satisfied with option
      #  cmd - command to be tested
      #  Example
      #     options = {"enable_facebook" => false}
      #     task = {"require_true" => ["enable_facebook"]}
      #     task_satisfy?(task, options)
      #     # => false
      #
      #     options = {"enable_facebook" => true, "app_id"=> ''}
      #     task = {"require_true" => ["enable_facebook"],"require_false"=>["app_id"]}
      #     task_satisfy?(task, options)
      #     # => false
      #
      #     options = {"enable_facebook" => true, "app_id"=> '1234'}
      #     task = {"require_true" => ["enable_facebook"],"require_false"=>["app_id"]}
      #     task_satisfy?(task, options)
      #     # => true
      def task_satisfy?(task, options)
        return true if task['require_true'].nil?
        task['require_true'].each { |requirement| return false if !options[requirement] } unless task['require_false'].nil?
        task['require_false'].each { |requirement| return false if options[requirement]!= '' } unless task['require_false'].nil?
        return true
      end
    end
  end
end