module POEditor
  class Configuration
    # @return [String] POEditor API key
    # @see https://poeditor.com/account/api POEditor API Access
    attr_accessor :api_key

    # @return [String] POEditor project ID
    attr_accessor :project_id

    # @return [String] Export file type (po, apple_strings, android_strings)
    attr_accessor :type

    # @return [Array<String>] Tag filters (optional)
    attr_accessor :tags

    # @return [Array<String>] The languages codes
    attr_accessor :languages

    # @return [Hash{Sting => String}] The languages aliases
    attr_accessor :language_alias

    # @return [String] The path template
    attr_accessor :path

    # @return [Hash{Sting => String}] The path replacements
    attr_accessor :path_replace

    def initialize(api_key:, project_id:, type:, tags:nil,
                   languages:, language_alias:nil,
                   path:, path_replace:nil)
      @api_key = from_env(api_key)
      @project_id = from_env(project_id.to_s)
      @type = type
      @tags = tags || []

      @languages = languages
      @language_alias = language_alias || {}

      @path = path
      @path_replace = path_replace || {}
    end

    def from_env(value)
      if value.start_with?("$")
        key = value[1..-1]
        ENV[key]
      else
        value
      end
    end

    def to_s
      values = {
        "type" => self.type,
        "tags" => self.tags,
        "languages" => self.languages,
        "language_alias" => self.language_alias,
        "path" => self.path,
        "path_replace" => self.path_replace,
      }
      YAML.dump(values)[4..-2]
        .each_line
        .map { |line|
          if line.start_with?("-") or line.start_with?(" ")
            "    #{line}"
          else
            "  - #{line}"
          end
        }
        .join("")
    end
  end
end
