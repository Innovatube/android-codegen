require 'thor'
require_relative 'generator'
require 'json'
require_relative 'utilities'
require_relative 'custom_erubis'
##
#Class' description
#
#@author::          Ethan Le
#@usage::           CLI endpoint
#@revision::        28/3/2017
#@todo::
#@fixme::
##

module AndroidBoilerplate
  class AndroidGenerator < Thor

    desc 'generate', 'this command will generate boilerplate project'

    def generate
      dir = File.join(File.dirname(__FILE__), 'templates')
      new_options = Hash.new
      templates = Array.new
      Dir["#{dir}/*.json"].each { |f| templates.push(f.gsub(/#{AndroidBoilerplate::Utilities.encode_string(File.dirname(f))}\/(.*?)-config.json/, '\1')) }
      continue = false;
      begin
        say "What template do you want to generate?\nThe available templates are: "
        say "#{templates}", :green
        template = ask('template: ', :limited_to => templates)
        puts template
        config_file = File.read(File.join(File.dirname(__FILE__), 'templates', "#{template}-config.json"));
        param_json = JSON.parse(config_file)
        param_json['params'].keys.each { |param|
          next if !param_json['params'][param]['require_true'].nil? && !new_options[param_json['params'][param]['require_true']]
          next if !new_options[param].nil? && in_white_list_config?(param)
          say param_json['params'][param]['message']
          if param_json['params'][param]['type'] == 'model'
            select_model(new_options)
          elsif !param_json['params'][param]['limited_to'].nil?
            command_option = Hash.new
            command_option[:limited_to] = param_json['params'][param]['limited_to'].split(',').map(&:strip)
            home_template = ask(param, command_option)
            puts home_template
            new_options[home_template] = true
          else
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
          end

        }
        new_options['base_dir'] = File.join(File.dirname(__FILE__), 'templates', 'mvp-boilerplate')
        new_options['directory']
        new_options['app_name']
        if new_options['directory'] == ''
          new_options['target_dir'] = new_options['app_name']
        else
          new_options['target_dir'] = "#{new_options['directory']}/#{new_options['app_name']}"
        end
        erubis = CustomErubis.new(config_file)
        param_json = JSON.parse(erubis.result(new_options))
        generator = AndroidBoilerplate::Generator.new(new_options)
        task_list = %w(copy_template_directory copy_template_file copy_file copy_directory merge_template_file)
        task_list.each do |task_name|
          next if param_json['tasks'][task_name].nil?
          param_json['tasks'][task_name].each do |task|
            next unless AndroidBoilerplate::Utilities.task_satisfy?(task, new_options)
            if task_name == 'merge_template_file'
              generator.merge_template_file(task['from'], task['to'], task['merge_type'])
            else
              generator.send(task_name, task['from'], task['to'], task['exclude']) unless param_json['tasks'][task_name].nil?
            end
          end
        end
        unless param_json['extra_tasks'].nil?
          param_json['extra_tasks'].each do |task|
            next unless AndroidBoilerplate::Utilities.task_satisfy?(task, new_options)
            case task['name']
              when 'swagger_codegen'
                swagger_codegen(new_options)
              when 'generate_facebook_hash'
                generate_facebook_hash(new_options)
              when 'generate_google_config'
                generate_google_config new_options
            end
          end
        end
        continue = ask('Do you want to generate another templates?', :limited_to => %w(yes no)) == 'yes'
      end while continue

    end

    desc 'generate-google-config', 'Generate Google play config'
    option :home_directory, :type => :boolean

    def generate_google_config(old_options = nil)
      say 'Generate config file for google sign in'
      say("the current directory is #{Dir.pwd}") if not options[:home_directory]
      say('What is the directory of keystore (leave it empty to use default keystore)?')
      keystore_directory = ask('The directory of keystore (leave it empty to use default keystore): ')
      if keystore_directory == ''
        keystore = `keytool -list -v -keystore #{default_keystore} -alias androiddebugkey -storepass android -keypass android | grep SHA1:`
      else
        say('What is your profile alias?')
        keystore_alias = ask('Alias: ')
        say('What is the keystore password?')
        key_password = ask('Password: ')
        say('What is the keystore password?')
        keystore_password = ask('Password: ')
        keystore = `keytool -list -v -keystore ~/.android/debug.keystore -alias #{keystore_alias} -storepass #{keystore_password} -keypass #{key_password}| grep SHA1:`
      end
      if !old_options.nil? && !old_options['app_name'].nil? && !old_options['package_name'].nil?
        url = "https://developers.google.com/mobile/add?platform=android&cntapi=signin&cntapp=#{old_options['app_name']}&cntpkg=#{old_options['package_name']}"
      else
        url = 'https://developers.google.com/mobile/add?platform=android&cntapi=signin'
      end

      say "Navigate to #{url} to set up project and download config file with the following info"
      say "Key hash: #{keystore}"
      open_browser url
    end

    desc 'generate-facebook-hash', 'Generate key hash'
    option :home_directory, :type => :boolean

    def generate_facebook_hash(old_options = nil)
      say 'Generate info for facebook'
      say("the current directory is #{Dir.pwd}") if not options[:home_directory]
      say('What is the directory of keystore (leave it empty to use default keystore)?')
      keystore_directory = ask('The directory of keystore (leave it empty to use default keystore): ')
      if keystore_directory == ''
        keystore = `keytool -exportcert -alias androiddebugkey -storepass android -keystore #{default_keystore} | openssl sha1 -binary | openssl base64`
      else
        say('What is your profile alias?')
        keystore_alias = ask('Alias: ')
        say('What is the keystore password?')
        keystore_password = ask('Password: ')
        keystore = `keytool -exportcert -alias #{keystore_alias} -storepass #{keystore_password} -keystore #{Dir.pwd}/#{keystore_directory} | openssl sha1 -binary | openssl base64`
      end
      url = 'https://developers.facebook.com/apps/'
      say "Navigate to #{url} to update or create your facebook app with the following info"
      say "Package name #{old_options['package_name']}" if !old_options.nil? && !old_options['package_name'].nil?
      say "Key hash: #{keystore}"
      open_browser url
    end

    desc 'swagger-codegen', 'Generate model or rxJava from Swagger YAML'

    def swagger_codegen(old_options = nil)
      unless AndroidBoilerplate::Utilities.command_available?('java')
        puts 'Java 7 or higher is required to run swagger-codegen'
        return
      end
      required_params = %w(directory package_name app_name)
      if old_options.nil?
        old_options = Hash.new
      end
      required_params.each do |param|
        if old_options[param].nil?
          case param
            when 'directory'
              old_options['directory'] = ask('Where is the directory containing your project?')
            when 'package_name'
              old_options['package_name'] = ask('What is the package name: ')
            when 'app_name'
              old_options['directory'] = ask('What is your app"s name ?')
          end
        end
      end
      yaml_file = ask('Enter path name for swagger file (url or local path, leave it empty to exit): ')
      return if yaml_file == ''
      old_options['generate_rx_java2'] = (ask('Do you want to generate RxJava2 alongside with model?', :limited_to => %w(yes no)) == 'yes')
      model_package = "#{old_options['package_name']}.data.models"
      api_package = "#{old_options['package_name']}.api"
      swagger_ignore = nil
      swagger_gradle = nil
      if old_options['generate_rx_java2']
        swagger_ignore = File.join(File.dirname(__FILE__), 'swagger', '.swagger-codegen-ignore-retrofit2rx2')
        swagger_gradle = File.join(File.dirname(__FILE__), 'templates', 'mvp-boilerplate/app/gradle_template/template_swagger_rxjava2.gradle')
      else
        swagger_gradle = File.join(File.dirname(__FILE__), 'templates', 'mvp-boilerplate/app/gradle_template/template_swagger_model.gradle')
        swagger_ignore = File.join(File.dirname(__FILE__), 'swagger', '.swagger-codegen-ignore-model')
      end
      swagger_ignore = File.join(File.dirname(__FILE__), 'swagger', '.swagger-codegen-ignore-model') unless old_options['generate_rx_java2']
      swagger_config = File.join(File.dirname(__FILE__), 'swagger', 'swagger-config.json')


      directory = "#{old_options['directory']}"
      directory = "#{directory}/#{old_options['app_name']}" unless old_options['app_name'].nil?
      directory = "#{directory}/app"
      target_swagger_ignore = File.join(directory, '.swagger-codegen-ignore')
      generate = AndroidBoilerplate::Generator.new old_options
      generate.merge_template_file(swagger_gradle, File.join(directory, 'build.gradle'), 'app_dependencies')
      FileUtils.mkpath (File.dirname(target_swagger_ignore)) unless File.exist?(File.dirname(target_swagger_ignore))
      FileUtils.cp(swagger_ignore, target_swagger_ignore)
      swagger_codegen_path = File.join(File.dirname(__FILE__), 'swagger-codegen-cli-2.2.2.jar')
      system("java -jar #{swagger_codegen_path} generate -i #{yaml_file} -l java --model-package #{model_package} --api-package #{api_package} -o #{directory} -c #{swagger_config}")
    end

    no_tasks do
      def select_model(old_option = nil)
        model_list = Array.new
        model_dir = File.join(old_option['directory'], old_option['app_name'], 'app/src/main/java', old_option['package_name'].gsub('.', '/'), 'data/models/')
        Dir["#{model_dir}*.java"].each { |f| model_list.push(f.gsub(model_dir, '')) }
        command_option = Hash.new
        command_option[:limited_to] = model_list
        old_option['model'] = ask('model', command_option)
        attributes = AndroidBoilerplate::Utilities.variables_of_model(File.join(model_dir, old_option['model']))
        old_option['attributes'] = {}
        attributes.each do |attribute|
          if (ask("Do you want to include #{attribute} in your view?", :limited_to => %w(yes no)) == 'yes')
            old_option['attributes'][attribute] =
                ask("What kind of view do you want to generate for #{attribute}", :limited_to => %w(TextView Button ImageView EditText SwitchCompat))
          end
        end
        old_option['sub_package_name'] = old_option['sub_package_name']=='' ? 'list' : old_option['sub_package_name']
        old_option['model'] = old_option['model'].gsub('.java', '')
      end

      def read_dir_configuration
        config = Hash.new
        if File.exist?('app') && File.directory?('app')
          current_dir = File.dirname(__FILE__)
          parent_dir = File.expand_path('..', current_dir)
          manifest = File.join(current_dir, 'app/src/main/AndroidManifest.xml')
          unless manifest.match(/(?<=package=").*?(?=")/).nil?
            package_name = manifest.match(/(?<=package=").*?(?=")/)[0]
          end
        end
        return config
      end

      def in_white_list_config?(config)
        white_list = %w(package_name directory app_name)
        white_list.include? config
      end

      def open_browser(url)
        if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
          system "start #{url}"
        elsif RbConfig::CONFIG['host_os'] =~ /darwin/
          system "open #{url}"
        elsif RbConfig::CONFIG['host_os'] =~ /linux|bsd/
          system "xdg-open #{url}"
        end
      end

      def default_keystore
        if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
          '%HOMEPATH%\.android\debug.keystore'
        else
          '~/.android/debug.keystore'
        end
      end
    end

  end
end