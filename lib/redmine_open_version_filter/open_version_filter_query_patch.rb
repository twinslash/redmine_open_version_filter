module OpenVersionFilterQueryPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable

      alias_method_chain :available_filters, :open_version_filter
    end
  end

  module InstanceMethods

    def available_filters_with_open_version_filter
      filters = available_filters_without_open_version_filter
      filters.merge!('in_open_versions' => {:type => :list, :values => [["Yes", "1"]], :order => 16, :name => l("field_in_open_versions")})
    end

    def sql_for_in_open_versions_field(field, operator, value)
      scope = project && project.shared_versions || Version
      version_ids = scope.open.visible.all(:conditions => 'effective_date IS NOT NULL').collect(&:id).push(0)

      if operator == '='
        "#{Issue.table_name}.fixed_version_id IN (#{version_ids.join(',')})"
      else
        "#{Issue.table_name}.fixed_version_id IS NULL OR #{Issue.table_name}.fixed_version_id NOT IN (#{version_ids.join(',')})"
      end
    end

  end

end
