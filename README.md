# Redmine Open Version Filter

This plugin adds new filters.

* **In opened versions**.
If this filter is enabled then user will see issues belong to versions which are "opened" and have *date*. This behavior allows admin create opened versions without date and add issues to these versions. Users will not see these future tasks when they apply the filter.

* **Out of opened versions**.
If this filter is enabled then user will see issues without version or in versions without date. This filter should help Project Managers control future tasks.

## Installation
To install the plugin run clone from plugin directory (REDMINE/plugins):
```bash
cd REDMINE/plugins
git clone https://github.com/twinslash/redmine_open_version_filter.git
```
Restart your Redmine server

## Uninstallation
Delete folder with the plugin
```bash
cd REDMINE/plugins
rm redmine_open_version_filter -rf
```

Restart your Redmine server
