require 'redmine_open_version_filter/open_version_filter_query_patch'
Rails.configuration.to_prepare do
  IssueQuery.send(:include, IssueQueryPatch)
end
