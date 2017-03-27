require 'thor'
require 'android/boilerplate'
require 'android/boilerplate/generator'
require 'json'
require_relative 'utilities'
require_relative './erb_helper'
##
#Class' description
#
#@author::          Ethan Le
#@usage::           CLI endpoint
#@revision::        22/3/2017
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
          next unless new_options[param].nil?
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
        new_options['base_dir'] = File.join(File.dirname(__FILE__), 'templates', 'mvp-boilerplate')
        erubis = Erubis::Eruby.new(config_file)
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
                generate_key_hash
            end
          end
        end
        continue = ask('Do you want to generate another templates?', :limited_to => %w(yes no)) == 'yes'
      end while continue

    end

    desc 'generate-key-hash', 'Generate key hash'
    option :home_directory, :type => :boolean

    def generate_key_hash
      say("the current directory is #{Dir.pwd}") if not options[:home_directory]
      say('What is the directory of keystore (leave it empty to use default keystore)?')
      keystore_directory = ask('The directory of keystore: ')
      if keystore_directory == ''
        say('Use the following hash key to create new android client:')
        exec('keytool -exportcert -alias androiddebugkey -storepass android -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64')
      else
        say('What is your profile alias?')
        keystore_alias = ask('Alias: ')
        say('What is the keystore password?')
        keystore_password = ask('Password: ')
        say('Use the following hash key to create new android client:')
        exec "keytool -exportcert -alias #{keystore_alias} -storepass #{keystore_password} -keystore #{Dir.pwd}/#{keystore_directory} | openssl sha1 -binary | openssl base64"
      end
    end

    desc 'swagger-codegen', 'Generate model or rxJava from Swagger YAML'

    def swagger_codegen(old_options = nil)
      system('brew install swagger-codegen') unless AndroidBoilerplate::Utilities.command_available?('swagger-codegen')
      if old_options.nil?
        old_options = Hash.new
        old_options['directory'] = ask('Which directory you want to store your models?')
        old_options['package_name'] = ask('Package name: ')
      end
      yaml_file = ask('Enter path name for swagger file (url or local path): ')
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
      system("swagger-codegen generate -i #{yaml_file} -l java --model-package #{model_package} --api-package #{api_package} -o #{directory} -c #{swagger_config}")
    end

    desc 'generate-list', 'generate list from selected model'
    def generate_list(old_option = nil)
      if old_option.nil?
        old_option = Hash.new
        old_option['directory'] = ask('What is the directory of your project?', :path => true)
        old_option['package_name'] = ask('What is your package name');
        old_option['app_name'] = ask('What is your app name?');
      end
      model_list = Array.new
      model_dir = File.join(old_option['directory'], old_option['app_name'], 'app/src/main/java', old_option['package_name'].gsub('.', '/'), 'data/models/')
      Dir["#{model_dir}*.java"].each { |f| model_list.push(f.gsub(model_dir, '')) }
      command_option = Hash.new
      command_option[:limited_to] = model_list
      old_option['model'] = ask('model', command_option)
      attributes = AndroidBoilerplate::Utilities.variables_of_model(File.join(model_dir, old_option['model']))
      old_option['attributes'] = {}
      attributes.each do |attribute|
        if(ask("Do you want to include #{attribute} in your view?", :limited_to=>%w(yes no)) == 'yes')
          old_option['attributes'][attribute] =
              ask("What kind of view do you want to generate for #{attribute}", :limited_to => %w(TextView Button ImageView EditText SwitchCompat))
        end
      end
      old_option['sub_package_name'] = ask('What is your sub package name?')
      old_option['sub_package_name'] = old_option['sub_package_name']==''?'list':old_option['sub_package_name']
      old_option['model'] = old_option['model'].gsub('.java','')
      template_src_dir = File.join(File.dirname(__FILE__), 'templates', 'mvp-boilerplate/app/src/main/java/com/innovatube/carbid/ui/template/list');
      template_res_dir = File.join(File.dirname(__FILE__), 'templates', 'mvp-boilerplate/app/src/main/res/layout');
      target_src_dir = File.join(old_option['directory'], old_option['app_name'], 'app/src/main/java', old_option['package_name'].gsub('.', '/'),"ui/#{old_option['sub_package_name']}")
      target_res_dir = File.join(old_option['directory'], old_option['app_name'], 'app/src/main/res/layout')
      generator = AndroidBoilerplate::Generator.new(old_option)
      generator.copy_template_file(File.join(template_src_dir, 'ListTemplateModelAdapter.java'), File.join(target_src_dir,"List#{old_option['model'].capitalize}Adapter.java" ))
      generator.copy_template_file(File.join(template_src_dir, 'ListTemplateModelFragment.java'), File.join(target_src_dir,"List#{old_option['model'].capitalize}Fragment.java" ))
      generator.copy_template_file(File.join(template_src_dir, 'ListTemplateModelMvp.java'), File.join(target_src_dir,"List#{old_option['model'].capitalize}Mvp.java" ))
      generator.copy_template_file(File.join(template_src_dir, 'ListTemplateModelPresenter.java'), File.join(target_src_dir,"List#{old_option['model'].capitalize}Presenter.java" ))
      generator.copy_template_file(File.join(template_res_dir, 'template_list_template_model_item.xml'), File.join(target_res_dir,"list_#{to_snake_case(old_option['model'])}_item.xml" ))
      generator.copy_template_file(File.join(template_res_dir, 'template_fragment_list_template_model.xml'), File.join(target_res_dir,"fragment_list_#{to_snake_case(old_option['model'])}.xml" ))
    end
  end
end