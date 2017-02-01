require "colorize"
require "fileutils"
require "shellwords"
require "yaml"

module POEditor
  autoload :Version,   "poeditor/version"
  autoload :Exception, "poeditor/exception"
  autoload :UI,        "poeditor/ui"

  # core
  autoload :Core,   "poeditor/core"

  # command
  autoload :Command,        "poeditor/commands/command"
  autoload :PullCommand,    "poeditor/commands/pull_command"
  autoload :HelpCommand,    "poeditor/commands/help_command"
  autoload :VersionCommand, "poeditor/commands/version_command"

  # configuration
  autoload :Configuration, "poeditor/configuration"
end
