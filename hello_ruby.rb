require 'yaml'

# used to test ruby
cnf = YAML::load(File.open('config_webclerk.yml'))

pdmPaths = cnf['pdmPaths']

puts pdmPaths
