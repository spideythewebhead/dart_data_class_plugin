import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/assist/assist_contributor_mixin.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:data_class_plugin/src/contributors/available_assists.dart';
import 'package:data_class_plugin/src/contributors_delegates/code_generation_delegate.dart';
import 'package:data_class_plugin/src/contributors_delegates/file_generation/file_generation_data_class_delegate.dart';
import 'package:data_class_plugin/src/contributors_delegates/in_place/in_place_data_class_delegate.dart';
import 'package:data_class_plugin/src/extensions/extensions.dart';
import 'package:data_class_plugin/src/mixins.dart';
import 'package:data_class_plugin/src/options/data_class_plugin_options.dart';

class DataClassAssistContributor extends Object
    with AssistContributorMixin, ClassAstVisitorMixin, RelativeFilePathMixin
    implements AssistContributor {
  DataClassAssistContributor(
    this.targetFilePath, {
    DataClassPluginOptions? pluginOptions,
  }) : _pluginOptions = pluginOptions;

  @override
  final String targetFilePath;

  @override
  late final DartAssistRequest assistRequest;

  @override
  late final AssistCollector collector;

  @override
  AnalysisSession get session => assistRequest.result.session;

  final DataClassPluginOptions? _pluginOptions;

  @override
  Future<void> computeAssists(
    covariant DartAssistRequest request,
    AssistCollector collector,
  ) async {
    assistRequest = request;
    this.collector = collector;
    await _generateDataClass();
  }

  Future<void> _generateDataClass() async {
    final ClassDeclaration? classNode = findClassDeclaration();
    if (classNode == null || classNode.declaredElement == null) {
      return;
    }

    final ClassElement classElement = classNode.declaredElement!;
    if (classElement.hasUnionAnnotation || !classElement.hasDataClassAnnotation) {
      return;
    }

    final ChangeBuilder changeBuilder = ChangeBuilder(session: session);
    final DataClassPluginOptions pluginOptions =
        _pluginOptions ?? await session.analysisContext.contextRoot.root.getPluginOptions();

    final CodeGenerationDelegate delegate =
        pluginOptions.generationMode == CodeGenerationMode.inPlace
            ? InPlaceDataClassDelegate(
                relativeFilePath: relativeFilePath,
                targetFilePath: targetFilePath,
                classElement: classElement,
                classNode: classNode,
                pluginOptions: pluginOptions,
                changeBuilder: changeBuilder,
              )
            : FileGenerationDataClassDelegate(
                relativeFilePath: relativeFilePath,
                targetFilePath: targetFilePath,
                changeBuilder: changeBuilder,
                pluginOptions: pluginOptions,
                classNode: classNode,
                classElement: classElement,
                compilationUnit: assistRequest.result.unit,
              );

    await delegate.generate();
    addAssist(AvailableAssists.dataClass, changeBuilder);
  }
}
