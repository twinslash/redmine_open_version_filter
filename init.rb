require 'redmine'
require 'redmine_open_version_filter'
require_dependency 'redmine_open_version_filter/hooks'

Redmine::Plugin.register :redmine_open_version_filter do
  name 'Redmine Open Version Filter plugin'
  author '//Twinslash'
  description "This plugin adds a new filter 'in open versions'"
  version '0.0.1'
  url 'https://github.com/twinslash/redmine_open_version_filter'
  author_url 'http://twinslash.com'
end
