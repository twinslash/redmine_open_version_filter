module RedmineOpenVersionFilter
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={})
      if context[:controller] &&
        (context[:controller].is_a?(IssuesController) || context[:controller].is_a?(QueriesController))
        javascript_include_tag('open_version_filter.js', :plugin => 'redmine_open_version_filter')
      end
    end
  end
end
