import 'dart:io' as io show File;

import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:data_class_plugin/src/options/options.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

export 'options.dart';

part 'data_class_plugin_options.gen.dart';

@Enum(fromJson: true)
enum CodeGenerationMode {
  inPlace('in_place'),
  file('file');

  /// Default constructor of [CodeGenerationMode]
  const CodeGenerationMode(this.name);

  final String name;

  /// Creates an instance of [CodeGenerationMode] from [json]
  factory CodeGenerationMode.fromJson(String json) {
    return CodeGenerationMode.values.firstWhere((CodeGenerationMode e) => e.name == json);
  }
}

@DataClass()
abstract class DataClassPluginOptions {
  /// Default constructor
  const factory DataClassPluginOptions({
    CodeGenerationMode generationMode,
    List<Glob> allowedFilesGenerationPaths,
    int generatedFileLineLength,
    JsonOptions json,
    DataClassOptions dataClass,
    EnumOptions $enum,
    UnionOptions union,
  }) = _$DataClassPluginOptionsImpl;

  /// Creates an instance of [DataClassPluginOptions] from [json]
  factory DataClassPluginOptions.fromJson(Map<dynamic, dynamic> json) =
      _$DataClassPluginOptionsImpl.fromJson;

  @DefaultValue(CodeGenerationMode.inPlace)
  CodeGenerationMode get generationMode;

  static List<Glob> _stringsToGlobsFromJson(Map<dynamic, dynamic> json) {
    if (json['file_generation_paths'] == null) {
      return const <Glob>[];
    }

    final List<dynamic> paths = json['file_generation_paths'] as List<dynamic>;
    return List<Glob>.unmodifiable(<Glob>[
      for (final String path in paths) Glob(path),
    ]);
  }

  @JsonKey(fromJson: DataClassPluginOptions._stringsToGlobsFromJson)
  @DefaultValue(<Glob>[])
  List<Glob> get allowedFilesGenerationPaths;

  @DefaultValue(80)
  int get generatedFileLineLength;

  @DefaultValue(JsonOptions())
  JsonOptions get json;

  @DefaultValue(DataClassOptions())
  DataClassOptions get dataClass;

  @JsonKey(name: 'enum')
  @DefaultValue(EnumOptions())
  EnumOptions get $enum;

  @DefaultValue(UnionOptions())
  UnionOptions get union;

  static Future<DataClassPluginOptions> fromFile(io.File file) async {
    try {
      final YamlMap yaml = await file.readAsString().then((String value) => loadYaml(value));
      return DataClassPluginOptions.fromJson(yaml);
    } catch (_) {
      return const DataClassPluginOptions();
    }
  }
}
