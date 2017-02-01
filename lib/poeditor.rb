require "colorize"
require "fileutils"
require "shellwords"
require "yaml"

module POEditor
  autoload :Version,   "poeditor/version"
  autoload :Exception, "poeditor/exception"
  autoload :UI,        "poeditor/ui"

  # core
  autoload :Exporter,   "poeditor/core/exporter"
  autoload :Formatter,  "poeditor/core/formatter"

  # command
  autoload :Command,        "poeditor/commands/command"
  autoload :ExportCommand,  "poeditor/commands/export_command"
  autoload :HelpCommand,    "poeditor/commands/help_command"
  autoload :VersionCommand, "poeditor/commands/version_command"

  # configuration
  autoload :ExportConfiguration, "poeditor/configurations/export_configuration"
end
