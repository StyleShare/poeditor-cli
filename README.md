# poeditor-cli

[![Gem](https://img.shields.io/gem/v/poeditor-cli.svg)](https://rubygems.org/gems/poeditor-cli)
[![Build Status](https://travis-ci.org/StyleShare/poeditor-cli.svg?branch=master)](https://travis-ci.org/StyleShare/poeditor-cli)
[![Codecov](https://img.shields.io/codecov/c/github/StyleShare/poeditor-cli.svg)](https://codecov.io/gh/StyleShare/poeditor-cli)

Command line application for [POEditor](https://poeditor.com).

<img alt="poeditor-cli" src="https://cloud.githubusercontent.com/assets/931655/22522393/c6d3db32-e8fe-11e6-97f1-259445bc04d1.png" width="680">

## Features

* 📚 Exporting translation files directly from POEditor to your project directory
* 🎲 Mapping translation directory dynamically
* 🍎 Replacing `%s` with `%@` for Apple strings
* 📦 We use it in our products

## Installation

```console
$ [sudo] gem install poeditor-cli
```

## Usage

A single command will do almost everything for you.

```console
$ poeditor pull
```

Before you do this, you have to create a **poeditor.yml** file. This is a configuration file for poeditor-cli. Here is an example **`poeditor.yml`**:

```yaml
api_key: YOUR_API_KEY
project_id: PROJECT_ID
type: apple_strings
tags: [ios]

languages: [en, ko, ja, zh-Hans, zh-Hant, fr, es]
language_alias:
  zh: zh-Hans

path: Resources/{LANGUAGE}.lproj/Localizable.strings
path_replace:
  en: Resources/Base.lproj/Localizable.strings
```

> See **[Example `poeditor.yml` files](#example-poeditoryml-files)** section for more examples.

* **api_key**

    Your POEditor API key. You can check it on [POEditor API Access](https://poeditor.com/account/api). Use such like `$MY_API_KEY` to use environment variable.

* **project_id**

    POEditor project ID. You can check this value on the web browser's address bar. (For example: `https://poeditor.com/projects/view?id=XXXXX`) Use such like `$MY_PROJECT_ID` to use environment variable.

* **languages**

    Language codes to export. Use the language codes that your project uses. For example, use `zh-Hans` for Xcode project and `zh-rCN` for Android project even though POEditor uses `zh-CN` for simplified chinese.

* **language_alias** *(Optional)*

    Specify this value to copy the translation file to another language. For example, `zh` is same with the translation of `zh-Hans` or `zh-rCN`. In this case, you can specify the `language_alias` value as follows:

    ```yaml
    languages: [ko, ja, zh-Hans, zh-Hant]
    language_alias:
      zh: zh-Hans
    ```

* **path**

    The path for translation files to be downloaded. Each values of `languages` will be used for filling `{LANGUAGE}` placeholder.

* **path_replace** *(Optional)*

    Specify this value to enforce the translation file path. For example, Android uses `values/strings.xml` for default language and `values-ko/strings.xml` or `values-ja/strings.xml` for others. In this case, you can specify the `path_replace` as follows:

    ```yaml
    path: myapp/src/main/res/values-{LANGUAGE}/strings.xml
    path_replace:
      en: myapp/src/main/res/values/strings.xml
    ```

* **type**

    Translation file format. (po, pot, mo, xls, csv, resw, resx, android_strings, apple_strings, xliff, properties, key_value_json, json, xmb, xtb)

* **tags** *(Optional)*

    Terms which contain whole tags will be exported. (`&&`)

## Example `poeditor.yml` files

* Xcode project

    ```yaml
    api_key: $POEDITOR_API_KEY        # from envvar
    project_id: $POEDITOR_PROJECT_ID  # from envvar
    type: apple_strings
    tags: [ios]

    languages: [en, ko, ja, zh-Hans, zh-Hant]
    path: Resources/{LANGUAGE}.lproj/Localizable.strings
    ```

* Android project

    ```yaml
    api_key: $POEDITOR_API_KEY        # from envvar
    project_id: $POEDITOR_PROJECT_ID  # from envvar
    type: android_strings
    tags: [android]

    languages: [en, ko, ja, zh-rCN, zh-rTW]

    path: myapp/src/main/res/values-{LANGUAGE}/strings.xml
    path_replace:
      en: myapp/src/main/res/values/strings.xml
    ```

* Projects using gettext

    ```yaml
    api_key: $POEDITOR_API_KEY        # from envvar
    project_id: $POEDITOR_PROJECT_ID  # from envvar
    type: po

    languages: [en, ko, ja, zh_Hans, zh_Hant]
    language_alias:
      zh: zh_Hans

    path: myservice/translations/{LANGUAGE}/LC_MESSAGES/messages.po
    ```

## License

**poeditor-cli** is written by [Suyeol Jeon](https://github.com/devxoul) and available under MIT license.
