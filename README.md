# Data Class Plugin

[![CI Workflow](https://github.com/spideythewebhead/dart_data_class_plugin/actions/workflows/ci.yml/badge.svg)](https://github.com/spideythewebhead/dart_data_class_plugin/actions/workflows/ci.yml)
![Pub Version](https://img.shields.io/pub/v/data_class_plugin)

<!---
![Pub Publisher](https://img.shields.io/pub/publisher/data_class_plugin)
-->

**Data Class Plugin** is a tool that uses Dart's Analyzer to generate code on-the-fly.

## How it works

This plugin uses the [analyzer](https://pub.dev/packages/analyzer) system and [analyzer plugin](https://pub.dev/packages/analyzer_plugin) to get access on the source code and provide actions based on that.

## How to install

1. In your project's pubspec.yaml add on `dependencies` the following
   ```yaml
   dependencies:
     data_class_plugin: ^0.0.1
   ```
1. Update your `analysis_options.yaml` _(in case you don't have it, just create a new one)_

   **Minimal analysis_options.yaml**

   ```yaml
   include: package:lints/recommended.yaml

   # You need to register the plugin under analyzer > plugins
   analyzer:
     plugins:
       - data_class_plugin
   ```

1. Restart the analysis server

   **VSCode**

   1. Open the Command Palette
      1. **Windows/Linux:** Ctrl + Shift + P
      1. **MacOS:** ⌘ + Shift + P
   1. Type and select "Dart: Restart Analysis Server"

   **IntelliJ**

   1. Open Find Action
      1. **Windows/Linux:** Ctrl + Shift + A
      1. **MacOS:** ⌘ + Shift + A
   1. Type and select "Restart Dart Analysis Server"

## Generate the code you want!

### DataClass Annotation

1. Create a simple class, annotate it with `@DataClass()` and provide `final public` fields for your model.

   ```dart
   @DataClass()
   class User {
      final String id;
      final String username;
   }
   ```

1. Place the cursor anywhere inside the `User` class
1. Run code actions on your IDE

   VSCode

   1. **Windows/Linux:** Ctrl + .
   1. **MacOS:** ⌘ + .

   Intellij

   1. **Windows/Linux:** Alt + Enter
   1. **MacOS:** ⌘ + Enter

<img src="https://github.com/spideythewebhead/data_class_plugin/blob/main/assets/screenshots/010.png" width="400">

Available methods are:

1. **copyWith**

   Generates a new instance of the class with optionally provide new fields values.

   _If no value is provided (default), then **true** is assumed._

   ```dart
   MyClass copyWith(...) { ... }
   ```

2. **hashAndEquals**

   Implements hashCode and equals methods.

   _If no value is provided (default), then **true** is assumed._

   ```dart
   @override
   bool operator ==(Object other) { ... }

   @override
   int get hashCode { ... }
   ```

3. **$toString**

   Implements toString method.

   _If no value is provided (default), then **true** is assumed._

   ```dart
   @override
   String toString() { ... }
   ```

4. **fromJson**

   Generates a factory constructor that creates a new instance from a Map.

   _If no value is provided (default), then **false** is assumed_

   ```dart
   factory MyClass.fromJson(Map<dynamic, dynamic> json) { ... }
   ```

5. **toJson**

   Generates a function that coverts this instance to a Map.

   _If no value is provided (default), then **false** is assumed._

   ```dart
   Map<String, dynamic> toJson() { ... }
   ```

_This configuration can be overriden in `data_class_plugin_options.yaml`, see [Configuration](#Configuration)_

### Union Annotation

Adding this annotation to a class enables it to create union types.

<img src="https://github.com/spideythewebhead/data_class_plugin/blob/main/assets/screenshots/009.png" width="450">

Available union annotation toggles are:

1. **dataClass**

   Toggles code generation for **toString**, **copyWith**, **equals** and **hashCode**.

   _If no value is provided (default), then **true** is assumed._

1. **toJson**

   Toggles code generation for **fromJson**.

   _If no value is provided (default), then **true** is assumed._

1. **fromJson**

   Toggles code generation for **toJson**.

   _If no value is provided (default), then **true** is assumed._

### Enums

1. Create an enumeration with the last field closed by semicolon

   ```dart
   enum Category {
      science,
      sports;
   }
   ```

1. Place the cursor anywhere inside the `Category` enum

1. Run code actions on your IDE

   VSCode

   1. **Windows/Linux:** Ctrl + .
   1. **MacOS:** ⌘ + .

   Intellij

   1. **Windows/Linux:** Alt + Enter
   1. **MacOS:** ⌘ + Enter

1. A list with the following actions will be displayed
   1. Generate constructor
   1. Generate 'fromJson'
   1. Generate 'toJson'
   1. Generate 'toString'

> Enums can have an optional single field of primary type to be used in the _fromJson_ or _toJson_ transforms,
> if not provided then the `.name` is used as the default json value.

```dart
enum Category {
   science(0),
   sports(1);

   final int value;
}
```

<img src="https://github.com/spideythewebhead/data_class_plugin/blob/main/assets/screenshots/007.png" width="400">

## Configuration

You can customize the generated code produced by **Data Class Plugin**.

#### Configuration file

To create a custom configuration you need to add a file named `data_class_plugin_options.yaml` in the root folder of your project.

#### Available options

1. `json`
   
   Set the default naming convention for json keys.

   You can also override the default naming convention for the specified directories.

   > Supported naming conventions: `camelCase`, `snake_case`, `kebab-case` & `PascalCase`.

2. `data_class`

   Set the default values for the provided methods of the `@DataClass` annotation, 
   by specifying the directories where they will be enabled or disabled.

#### Configuration examples

```yaml
json:
  # Default naming convention for json keys
  key_name_convention: camel_case (default) | snake_case | kebab_case | pascal_case

  # Maps naming conventions to globs
  # You can provide a map of all the conventions you need and then a list with all the globs
  # key_name_conventions glob match takes precedence over key_name_convention
  key_name_conventions:
    <camel_case | snake_case | kebab_case | pascal_case>:
      - "a/glob/here"
      - "another/glob/here"

data_class:
  options_config:
    # For each of the provided methods you can provide a configuration
    # The configuration can be an enabled or disabled field that contains a list of globs
    # Default values for each options
    # copy_with, hash_and_equals, to_string (true), from_json, to_json (false)
    <copy_with | hash_and_equals | to_string | from_json | to_json>:
      default: boolean
      enabled:
        - "a/glob/here"
        - "another/glob/here"
      disabled:
        - "a/glob/here"
        - "another/glob/here"
```

## Notes

> If the generated method doesn't exist it will be placed in the end of the class/enum body (before `}`), otherwise it will be re-generated to be up-to-date with current snapshot of the code (fields, annotations configuration).

> The constructor is always generated at the start of the body (after `{`) for classes.
>```dart
>class MyClass {
>   // constructor will be generated here
>   
>   final int a;
>}
>```

> The constructor is always generated after the semicolon (`;`) in the values declaration for enums.
>```dart
>enum MyEnum {
>   a,
>   b,
>   c;
>   
>   // constructor will be generated here
>}
>```

## Examples
You can find a variety of examples in the [Example](https://github.com/spideythewebhead/dart_data_class_plugin/tree/main/example/lib) folder.

## Development

In order to see your changes in the plugin you need to modify `tools/analyzer_plugin/pubspec.yaml` and add the following section

```yaml
dependency_overrides:
  data_class_plugin:
    path: /absolute/path/to/root_project
```

And restart the analysis server _(in case that fails run pub_get.sh)_.

## Known Issues

1. When using IntelliJ/Android Studio the `$toString` parameter of the **@DataClass** annotation is not visible in the Suggestions list.
   However, you can still use it by typing it.
