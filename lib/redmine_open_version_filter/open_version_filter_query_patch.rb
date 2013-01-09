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

    def available_filters_with_open_version_filter
      filters = available_filters_without_open_version_filter
      filters.merge!('in_open_versions' =>
        {:type => :in_open_versions,
         :values => [],
         :order => 16,
         :name => l("field_in_open_versions")})
    end

    def sql_for_in_open_versions_field(field, operator, value)
      scope = project && project.shared_versions || Version
      version_ids = scope.open.visible.all(:conditions => 'effective_date IS NOT NULL').collect(&:id).push(0)
      # do not care about operator and value - just add a condition if filter "in_open_versions" is enabled
      "#{Issue.table_name}.fixed_version_id IN (#{version_ids.join(',')})"
    end

    def add_filter_error_with_open_version_filter(field, message)
      add_filter_error_without_open_version_filter(field, message) unless field == 'in_open_versions'
    end

  end

end
