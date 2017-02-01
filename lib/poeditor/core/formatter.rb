module POEditor
  class Formatter
    def self.build_path(path_template, language)
      path_template.gsub "{LANGUAGE}", language
    end

    def self.write(path_template, language, content)
      path = build_path(path_template, language)
      unless File.exist?(path)
        raise POEditor::Exception.new "#{path} doesn't exist"
      end
      File.write(path, content)
      UI.puts "      #{"\xe2\x9c\x93".green} Saved at '#{path}'"
    end
  end
end
