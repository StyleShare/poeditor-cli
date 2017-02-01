module POEditor
  class ExportCommand
    def run(argv)
      UI.puts "Reading configuration"
      configuration = get_configuration(argv)
      UI.puts configuration
      exporter = POEditor::Exporter.new(configuration)
      exporter.export_all()
    end

    # Detects and returns the location of `poeditor.yml` file from the given
    # system arguments.
    #
    # @param argv [Array<String>] System arguments
    #
    # @return [String] The detected path of `poeditor.yml` file
    def get_configuration_file_path(argv)
      config_index = argv.index("-c") or argv.index("--config")
      if config_index
        config_path = argv[config_index + 1]
      else
        config_path = "poeditor.yml"
      end
    end

    # Returns {#POEditor::ExportConfiguration} from the given system arguments.
    #
    # @param argv [Array<String>] System arguments
    #
    # @return [POEditor::ExportConfiguration] The export configuration
    def get_configuration(argv)
      config_path = get_configuration_file_path(argv)
      unless File.exist?(config_path)
        raise POEditor::Exception.new %{\
Configuration file doesn't exist: #{config_path}.
    Try creating `poeditor.yml` or specifying the path using '--config'.\
        }
      end
      yaml = YAML.load(File.read(config_path))
      ExportConfiguration.new(
        api_key: get_or_raise(yaml, "api_key"),
        project_id: get_or_raise(yaml, "project_id"),
        type: get_or_raise(yaml, "type"),
        tags: yaml["tags"],
        languages: get_or_raise(yaml, "languages"),
        language_alias: yaml["language_alias"],
        path: get_or_raise(yaml, "path"),
        path_replace: yaml["path_replace"],
      )
    end

    # Returns the value of specified key from the given yaml instance. Raise
    # exception when there's no key in the yaml.
    #
    # @param yaml [YAML]
    # @param key [String]
    #
    # @return The value for the specified key from yaml
    # @raise [POEditor::Exception]
    def get_or_raise(yaml, key)
      yaml[key] or raise POEditor::Exception.new \
        "Missing configuration key: '#{key}'"
    end

  end
end
