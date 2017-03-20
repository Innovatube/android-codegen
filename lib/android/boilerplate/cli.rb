require 'thor'
require 'android/boilerplate'
require 'android/boilerplate/generator'
require 'json'
require_relative 'utilities'

##
#Class' description
#
#@author::          Ethan Le
#@usage::           CLI endpoint
#@revision::        date of the 20/3/2017
#@todo::
#@fixme::
##

module AndroidBoilerplate
  class AndroidGenerator < Thor

    desc 'greeting', 'This command will say hello to you'
    option :name, :type => 'string'
    def greeting
      puts "Hello #{options[:name]}"
    end

    desc 'generate', 'this command will generate boilerplate project'
    def generate
      dir = File.join(File.dirname(__FILE__), 'templates')
      new_options = Hash.new
      templates = Array.new
      Dir["#{dir}/*"].each { |f| templates.push(f.gsub("#{dir}/", '')) if (File.directory?(f)) }
      say "What template do you want to generate?\nThe available templates are: "
      say "#{templates}", :green
      template = ask('template: ', :limited_to => templates)
      puts template
      config_file = File.read(File.join(File.dirname(__FILE__), 'templates', template, 'config.json'));
      param_json = JSON.parse(config_file)
      param_json['params'].keys.each { |param|
        next if !param_json['params'][param]['require_true'].nil? && !new_options[param_json['params'][param]['require_true']]
        say param_json['params'][param]['message']
        command_option = Hash.new
        command_option[:limited_to] = %w(yes no) if param_json['params'][param]['type'] == 'boolean'
        if command_option.size!=0
          new_options[param] = ask(param, command_option)
        else
          new_options[param] = ask(param)
        end

        if param_json['params'][param]['type'] == 'boolean'
          new_options[param] = new_options[param] == 'yes'
        end
      }
      new_options['base_dir'] = File.join(File.dirname(__FILE__), 'templates', template)
      erubis = Erubis::Eruby.new(config_file)
      param_json = JSON.parse(erubis.result(new_options))
      generator = AndroidBoilerplate::Generator.new(new_options)
      task_list = %w(copy_template_directory copy_directory copy_file copy_template_file)
      task_list.each do |task_name|
        param_json['tasks'][task_name].each do |task|
          next if !task['require_true'].nil? && !new_options[task['require_true']]
          next if !task['require_false'].nil? && new_options[task['require_false']]
          generator.copy_template_directory(task['from'], task['to'], task['exclude']) unless param_json['tasks']['copy_template_directory'].nil?
        end
      end
      param_json['extra_tasks'].each do |task|
        next if !AndroidBoilerplate::Utilities.task_satisfy?(task, new_options)
        case task['name']
          when 'generate_model'
            generate_model(new_options)
          when 'generate_facebook_hash'
            generate_key_hash
        end
      end
    end

    desc 'generate-key-hash', 'Generate key hash'
    option :home_directory, :type => :boolean

    def generate_key_hash
      say("the current directory is #{Dir.pwd}") if not options[:home_directory]
      say('What is the directory of keystore (leave it empty to use default keystore)?')
      keystore_directory = ask('The directory of keystore: ')
      if keystore_directory == ''
        exec('keytool -exportcert -alias androiddebugkey -storepass android -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64')
      else
        say('What is your profile alias?')
        keystore_alias = ask('Alias: ')
        say('What is the keystore password?')
        keystore_password = ask('Password: ')
        exec "keytool -exportcert -alias #{keystore_alias} -storepass #{keystore_password} -keystore #{Dir.pwd}/#{keystore_directory} | openssl sha1 -binary | openssl base64"
      end
    end

    desc 'generate-model', 'Generate model from Swagger YAML'
    def generate_model(old_options = nil)
      system('brew install swagger-codegen') unless AndroidBoilerplate::Utilities.command_available?('swagger-codegen')
        system('brew install swagger-codegen')
      if old_options.nil?
        old_options = Hash.new
        old_options['package_name'] = ask('Package name for your models:')
        old_options['directory'] = ask('Which directory you want to store your models')
      end
      yaml_file = ask('Enter path name for swagger file (url or local path): ')
      model=ask('Enter the model you want to generate:')
      model_package = "#{old_options['package_name']}.models"
      directory = "#{old_options['directory']}"
      directory = "#{directory}/#{old_options['app_name']}" unless old_options['app_name'].nil?
      directory = "#{directory}/app"
      exec("swagger-codegen generate -i #{yaml_file} -l android --model-package #{model_package} -o #{directory} -Dmodels=#{model}")
    end


  end
end