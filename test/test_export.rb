require_relative "test"

class ExportTest < Test

  def clean
    FileUtils.rm_rf("TestProj")
  end

  def setup
    clean()
    for language in ["en", "ko", "ja", "zh-Hans", "zh-Hant"]
      FileUtils.mkdir_p("TestProj/#{language}.lproj")
      File.write("TestProj/#{language}.lproj/Localizable.strings", "")
    end
  end

  def teardown
    WebMock.reset!
    clean()
  end

  def get_exporter(languages:, path:)
    configuration = POEditor::ExportConfiguration.new(
      :api_key => "TEST",
      :project_id => 12345,
      :languages => languages,
      :type => "apple_strings",
      :tags => nil,
      :path => path,
    )
    POEditor::Exporter.new(configuration)
  end

  def test_export_failure
    stub_api_export_failure()
    exporter = get_exporter(
      :languages => ["en", "ko"],
      :path => "",
    )
    assert_raises POEditor::Exception do exporter.export_all() end
  end

  def test_export
    stub_api_export "en", %{"greeting" = "Hi, %s!";}
    stub_api_export "ko", %{"greeting" = "%s님 안녕하세요!";}
    stub_api_export "zh-CN", %{"greeting" = "Simplified 你好, %s!";}
    stub_api_export "zh-TW", %{"greeting" = "Traditional 你好, %s!";}

    exporter = get_exporter(
      :languages => ["en", "ko", "zh-Hans", "zh-Hant"],
      :path => "TestProj/{LANGUAGE}.lproj/Localizable.strings"
    )
    exporter.export_all()
    
    assert_match "Hi, %@!",
      File.read("TestProj/en.lproj/Localizable.strings")

    assert_match "%@님 안녕하세요!",
      File.read("TestProj/ko.lproj/Localizable.strings")

    assert_match "Simplified 你好, %@!",
      File.read("TestProj/zh-Hans.lproj/Localizable.strings")

    assert_match "Traditional 你好, %@!",
      File.read("TestProj/zh-Hant.lproj/Localizable.strings")

    assert File.read("TestProj/ja.lproj/Localizable.strings").length == 0
  end

end
