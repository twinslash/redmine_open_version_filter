require 'redmine'
require 'redmine_open_version_filter'
require_dependency 'redmine_open_version_filter/hooks'

Redmine::Plugin.register :redmine_open_version_filter do
  name 'Redmine Open Version Filter plugin'
  author '//Twinslash'
  description "This plugin adds new filters 'in opened versions' and 'out of opened versions'"
  version '0.0.2'
  url 'https://github.com/twinslash/redmine_open_version_filter'
  author_url 'http://twinslash.com'
end
