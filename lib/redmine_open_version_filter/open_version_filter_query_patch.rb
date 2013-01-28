module OpenVersionFilterQueryPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable

      alias_method_chain :available_filters, :open_version_filter
      alias_method_chain :add_filter_error, :open_version_filter
    end
  end

  module InstanceMethods

    # add filters
    def available_filters_with_open_version_filter
      filters = available_filters_without_open_version_filter

      # filter: in_open_versions
      filters.merge!('in_open_versions' =>
        {:type => :in_open_versions,
         :values => [],
         :order => 16,
         :name => l("field_in_open_versions")})

      # filter: out_of_opened_versions
      filters.merge!('out_of_opened_versions' =>
        {:type => :out_of_opened_versions,
         :values => [],
         :order => 17,
         :name => l("field_out_of_opened_versions")})
    end

    # select issues in versions which are opened and with date
    def sql_for_in_open_versions_field(field, operator, value)
      scope = project && project.shared_versions || Version
      version_ids = scope.open.visible.all(:conditions => 'effective_date IS NOT NULL').collect(&:id).push(0)
      # do not care about operator and value - just add a condition if filter "in_open_versions" is enabled
      "(#{Issue.table_name}.fixed_version_id IN (#{version_ids.join(',')}))"
    end

    # select issues without versions or in versions which are opened and without date
    def sql_for_out_of_opened_versions_field(field, operator, value)
      scope = project && project.shared_versions || Version
      version_ids = scope.open.visible.all(:conditions => 'effective_date IS NULL').collect(&:id).push(0)
      # do not care about operator and value - just add a condition if filter "in_open_versions" is enabled
      "(#{Issue.table_name}.fixed_version_id IN (#{version_ids.join(',')}) OR #{Issue.table_name}.fixed_version_id IS NULL)"
    end

    # suppress errors for plugin's filters
    def add_filter_error_with_open_version_filter(field, message)
      add_filter_error_without_open_version_filter(field, message) unless field == 'in_open_versions' || field == 'out_of_opened_versions'
    end

  end

end
