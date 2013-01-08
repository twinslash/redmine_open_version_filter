require 'redmine_open_version_filter/open_version_filter_query_patch'
Rails.configuration.to_prepare do
  Query.send(:include, OpenVersionFilterQueryPatch)
end
