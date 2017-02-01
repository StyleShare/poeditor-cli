# poeditor-cli

[![Gem](https://img.shields.io/gem/v/poeditor-cli.svg)](https://rubygems.org/gems/poeditor-cli)
[![Build Status](https://travis-ci.org/StyleShare/poeditor-cli.svg?branch=master)](https://travis-ci.org/StyleShare/poeditor-cli)

Command line application for [POEditor](https://poeditor.com).

<img width="682" alt="poeditor-cli" src="https://cloud.githubusercontent.com/assets/931655/22509884/2aebebc2-e8d3-11e6-86e2-a9915ca755b5.png">

## Installation

```console
$ [sudo] gem install poeditor-cli
```

## Usage

1. **Create `poeditor.yml` file**

    Here is an example.

    ```yaml
    api_key: YOUR_API_KEY
    project_id: PROJECT_ID
    languages: [en, ko, jp, zh-Hans, zh-Hant, fr, es]
    path: example/Resources/{LANGUAGE}.lproj/Localizable.strings
    type: apple_strings
    tags: [ios]  # optional
    ```

    | Field | Description |
    |---|---|
    | `api_key` | Your POEditor API key. You can check it on [POEditor API Access](https://poeditor.com/account/api). |
    | `project_id` | POEditor project ID. You can check this value on the web browser's address bar.<br />For example: `https://poeditor.com/projects/view?id=XXXXX` |
    | `languages` | Language codes to export. Use your project's language code.<br />For example, use `zh-Hans` if you're working on Xcode project even though POEditor uses `zh-CN` for simplified chinese. |
    | `path` | The path for translation files to be downloaded. Each values of `languages` will be used for filling `{LANGUAGE}` placeholder. |
    | `type` | Translation file format. (po, pot, mo, xls, csv, resw, resx, android_strings, apple_strings, xliff, properties, key_value_json, json, xmb, xtb) |
    | `tags` | (Optional) Terms which contain whole tags will be exported. (`&&`) |

2. **Export using CLI**

    ```console
    $ poeditor export
    ```

3. **You're done! 🎉**

## License

**poeditor-cli** is written by [Suyeol Jeon](https://github.com/devxoul) and available under MIT license.
