require 'json'
require 'net/http'

module POEditor
  class Command
    # The entry point of the CLI application
    def self.run(argv)
      UI.enabled = true
      self.check_update
      command = self.command_class(argv).new
      begin
        command.run(argv)
      rescue POEditor::Exception => e
        puts "[!] #{e.message}".red
      end
    end

    def self.command_class(argv)
      case argv[0]
      when "pull"
        PullCommand
      when "--version"
        VersionCommand
      else
        HelpCommand
      end
    end

    def self.check_update
      begin
        uri = URI("https://api.github.com"\
                  "/repos/StyleShare/poeditor-cli/releases/latest")
        data = JSON(Net::HTTP.get(uri))
        latest = data["tag_name"]
        if Gem::Version.new(VERSION) < Gem::Version.new(latest)
          UI.puts %{\
poeditor-cli #{latest} is available. (You're using #{VERSION})
To update: `$ gem install poeditor-cli`
Changelog: https://github.com/StyleShare/poeditor-cli/releases\
          }.green
        end
      rescue
      end
    end
  end
end
