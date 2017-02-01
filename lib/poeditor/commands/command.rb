module POEditor
  class Command
    # The entry point of the CLI application
    def self.run(argv)
      UI.enabled = true
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
  end
end
