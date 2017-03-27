# Android::Boilerplate

Android boilerplate generator with command line

## Development

After checking out the repo, run `bin/setup` or `bundle install` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.  
~~Run `rake template:sync` to clone template from github, authentication may be required.~~  
To install this gem onto your local machine, run `rake install`. To release a new version, update the version number in `version.rb`, and then run `rake install`.

## Usage
After install this gem onto your machine, you can simply run `android-boilerplate`  
To run it without installing  you must run this command 
```ruby
bundle exec exe/android-boilerplate
```
Show available commands:
```ruby
bundle exec exe/android-boilerplate

```
The available commands are:

1. android-boilerplate generate
2. android-boilerplate generate-key-hash
3. android-boilerplate swagger_codegen 
4. android-boilerplate help

To create new template, create *template-name*-config.json in `lib/android/boilerplate/templates`  
```javascript
{
  "params": {
    "PARAM_NAME": {
      "message": "MESSAGE", //message to display, required
      "type": "boolean", //param type is boolean or not, not required
      "require_true": // require another param must be true, not required
    },...
  },
  "tasks": { 
    //the available tasks are : copy_template_directory copy_template_file copy_file copy_directory merge_template_file
    // copy_template_directory, copy_template_filec copy_file, copy_directory share the same configuration
    //Erubis will replace variables in input file wil actual data base on params
    "copy_template_file": [
      {
        "from": "INPUT FILE LOCATION",
        "to": "OUTPUT FILE LOCATION",
        "require_true": [ // require those params must be true, not required
          "enable_facebook_login"
        ],
        "require_false": [ // require those params must be false, not required
          "enable_google_login"
        ],
        "exclude": [ //File or folder include those values will be ignored
          "Presenter.java"
        ],...
      }
    ],
    //Erubis will replace variables in input file wil actual data base on params
    "merge_template_file": [
      {
        "from": "INPUT FILE LOCATION",
        "to": "OUTPUT FILE LOCATION",
        "merge_type": "resources" //replace strategy: dependency, resources, manifest, etc
      }
    ]
  },
  "extra_tasks": [//extra task will be run after `task`
    {
      "name": "generate_facebook_hash", //task name(generate_facebook_hash, swagger_codgen)
      "require_true": ["enable_facebook_login"], // require another param must be true, not required
      "require_false": ["facebook_app_id"] // require another param must be false, not required
    }
  ]
}
```
Template file/folder must be put in `lib/android/boilerplate/templates/mvp-boilerplate`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

