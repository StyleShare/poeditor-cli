module POEditor
  class ExportConfiguration
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

    attr_accessor :path

    def initialize(api_key:, project_id:, type:, tags:nil, languages:, path:)
      @api_key = api_key
      @project_id = project_id
      @type = type
      @tags = tags or []
      @languages = languages
      @path = path
    end

    def default_path(type)
      Formatter.cls(type).default_path
    end

    def to_s
      values = {
        "api_key" => self.api_key,
        "project_id" => self.project_id,
        "type" => self.type,
        "tags" => self.tags,
        "languages" => self.languages,
        "path" => self.path,
      }
      values.map { |key, value| "  - #{key}: #{value}" }.join "\n"
    end
  end
end
