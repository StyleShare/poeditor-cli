require "json"
require "net/http"

module POEditor
  class Exporter
    # @return [POEditor::ExportConfiguration] The configuration for export
    attr_accessor :configuration

    # @param configuration [POEditor::ExportConfiguration]
    def initialize(configuration)
      unless configuration.is_a? ExportConfiguration
        raise POEditor::Exception.new \
          "`configuration` should be an `ExportConfiguration`"
      end
      @configuration = configuration
    end

    # Request POEditor API
    #
    # @param action [String]
    # @param api_token [String]
    # @param options [Hash{Sting => Object}]
    #
    # @return [Net::HTTPResponse] The response object of API request
    # 
    # @see https://poeditor.com/api_reference/ POEditor API Reference
    def api(action, api_token, options={})
      uri = URI("https://poeditor.com/api/")
      options["action"] = action
      options["api_token"] = api_token
      return Net::HTTP.post_form(uri, options)
    end

    # Exports all translations
    def export_all()
      UI.puts "\nExport translations"
      for language in @configuration.languages
        UI.puts "  - Exporting '#{language}'"
        content = self.export(:api_key => @configuration.api_key,
                              :project_id => @configuration.project_id,
                              :language => language,
                              :type => @configuration.type,
                              :tags => @configuration.tags)
        Formatter.write(@configuration.path, language, content)
      end
    end

    # Export translation for specific language
    #
    # @param api_key [String]
    # @param project_jd [String]
    # @param language [String]
    # @param type [String]
    # @param tags [Array<String>]
    #
    # @return Downloaded translation content
    def export(api_key:, project_id:, language:, type:, tags:nil)
      options = {
        "id" => project_id,
        "language" => convert_to_poeditor_language(language),
        "type" => type,
        "tags" => (tags or []).join(","),
      }
      response = self.api("export", api_key, options)
      data = JSON(response.body)
      unless data["response"]["status"] == "success"
        code = data["response"]["code"]
        message = data["response"]["message"]
        raise POEditor::Exception.new "#{message} (#{code})"
      end

      download_uri = URI(data["item"])
      content = Net::HTTP.get(download_uri)

      case type
      when "apple_strings"
        content.gsub!(/(%(\d+\$)?)s/, '\1@')  # %s -> %@
      when "android_strings"
        content.gsub!(/(%(\d+\$)?)@/, '\1s')  # %@ -> %s
      end

      return content
    end

    def convert_to_poeditor_language(language)
      if language.downcase.match(/zh.+hans/)
        'zh-CN'
      elsif language.downcase.match(/zh.+hant/)
        'zh-TW'
      else
        language
      end
    end

  end
end
