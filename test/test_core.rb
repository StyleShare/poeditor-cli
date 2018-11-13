require_relative "test"

class CoreTest < Test

  def clean
    FileUtils.rm_rf("TestProj")
  end

  def setup
    clean()
    for language in ["en", "ko", "ja", "zh", "zh-Hans", "zh-Hant"]
      FileUtils.mkdir_p("TestProj/#{language}.lproj")
      File.write("TestProj/#{language}.lproj/Localizable.strings", "")
    end
    for language in ["en", "ko", "ja", "zh", "zh-rCN", "zh-rTW"]
      if language == "en"
        dirname = "TestProj/values"
      else
        dirname = "TestProj/values-#{language}"
      end
      FileUtils.mkdir_p(dirname)
      File.write("#{dirname}/strings.xml", "")
    end

    stub_api_export "en", %{"greeting" = "Hi, %s!";}
    stub_api_export "ko", %{"greeting" = "%s님 안녕하세요!";}
    stub_api_export "zh-CN", %{"greeting" = "Simplified 你好, %s!";}
    stub_api_export "zh-TW", %{"greeting" = "Traditional 你好, %s!";}
  end

  def teardown
    WebMock.reset!
    clean()
  end

  def get_client(type:,
                 languages:, language_alias:nil,
                 path:, path_replace:nil)
    configuration = POEditor::Configuration.new(
      :api_key => "TEST",
      :project_id => 12345,
      :type => type,
      :tags => nil,
      :filters => nil,
      :languages => languages,
      :language_alias => language_alias,
      :path_replace => path_replace,
      :path => path,
    )
    POEditor::Core.new(configuration)
  end

  def test_pull_failure
    stub_api_export_failure()
    client = get_client(
      :type => "apple_strings",
      :languages => ["en", "ko"],
      :path => "",
    )
    assert_raises POEditor::Exception do client.pull() end
  end

  def test_pull
    client = get_client(
      :type => "apple_strings",
      :languages => ["en", "ko", "zh-Hans", "zh-Hant"],
      :path => "TestProj/{LANGUAGE}.lproj/Localizable.strings"
    )
    client.pull()

    assert_match "Hi, %@!",
      File.read("TestProj/en.lproj/Localizable.strings")

    assert_match "%@님 안녕하세요!",
      File.read("TestProj/ko.lproj/Localizable.strings")

    assert_match "Simplified 你好, %@!",
      File.read("TestProj/zh-Hans.lproj/Localizable.strings")

    assert_match "Traditional 你好, %@!",
      File.read("TestProj/zh-Hant.lproj/Localizable.strings")

    assert File.read("TestProj/ja.lproj/Localizable.strings").length == 0
    assert File.read("TestProj/zh.lproj/Localizable.strings").length == 0
  end

  def test_pull_language_alias
    client = get_client(
      :type => "apple_strings",
      :languages => ["en", "ko", "zh-Hans", "zh-Hant"],
      :language_alias => {"zh" => "zh-Hans"},
      :path => "TestProj/{LANGUAGE}.lproj/Localizable.strings",
    )
    client.pull()

    assert_match "Simplified 你好, %@!",
      File.read("TestProj/zh-Hans.lproj/Localizable.strings")

    assert_match "Simplified 你好, %@!",
      File.read("TestProj/zh.lproj/Localizable.strings")
  end

  def test_pull_path_replace
    client = get_client(
      :type => "android_strings",
      :languages => ["en", "ko", "zh-rCN", "zh-rTW"],
      :path => "TestProj/values-{LANGUAGE}/strings.xml",
      :path_replace => {"en" => "TestProj/values/strings.xml"},
    )
    client.pull()

    refute File.exist?("TestProj/values-en/strings.xml")
    assert_match "Hi, %s!",
      File.read("TestProj/values/strings.xml")
  end

end
