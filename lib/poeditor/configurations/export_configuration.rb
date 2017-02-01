module POEditor
  class ExportConfiguration
    # @return [String] POEditor API key
    # @see https://poeditor.com/account/api POEditor API Access
    attr_accessor :api_key

    # @return [String] POEditor project ID
    attr_accessor :project_id

    # @return [Array<String>] The languages codes
    attr_accessor :languages

    # @return [String] Export file type (po, apple_strings, android_strings)
    attr_accessor :type

    # @return [Array<String>] Tag filters (optional)
    attr_accessor :tags

    attr_accessor :path

    def initialize(api_key:, project_id:, languages:, type:, tags:nil, path:)
      @api_key = api_key
      @project_id = project_id
      @languages = languages
      @type = type
      @tags = tags or []
      @path = path
    end

    def default_path(type)
      Formatter.cls(type).default_path
    end

    def to_s
      values = {
        "api_key" => self.api_key,
        "project_id" => self.project_id,
        "languages" => self.languages,
        "type" => self.type,
        "tags" => self.tags,
        "path" => self.path,
      }
      values.map { |key, value| "  - #{key}: #{value}" }.join "\n"
    end
  end
end
