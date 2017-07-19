# Android::Boilerplate

Android boilerplate generator with command line

## Development

After checking out the repo, run `bin/setup` or `bundle install` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.  
Run `rake template:sync` to clone template from github, authentication may be required.  
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
## Codegen
Open `terminal` and change directory to your project folder.
```
cd ~/AndroidStudioProjects
```
Create your project configration file, its structure will look like this:

```json
{
  "directory": "output",
  "package_name": "com.innovatube.carbid",
  "app_name": "Carbid",
  "target_sdk": 25,
  "min_sdk": 16,
  "rxVersion": "rxJava",
  "swagger_file":"http://petstore.swagger.io/v2/swagger.json"
}
```
`directory` is a relative path with current folder (where you run terminal), so please do not include `/`. it will lead to unexpected behavior (it will try to generate in `{root}/diretory`.
`swagger-file` is path of your swagger-file, it can be url or relative path to current directory.
`rxVersion` is **required**.
then simply run `android-codegen generate config-file-name.json`