import 'package:analyzer/dart/ast/ast.dart';
import 'package:data_class_plugin/src/backend/core/custom_dart_object.dart';
import 'package:data_class_plugin/src/backend/core/custom_dart_type.dart';
import 'package:data_class_plugin/src/backend/core/declaration_info.dart';
import 'package:data_class_plugin/src/backend/core/generators/generator.dart';
import 'package:data_class_plugin/src/common/code_writer.dart';
import 'package:data_class_plugin/src/extensions/extensions.dart';

class ConstructorGenerator implements Generator {
  ConstructorGenerator({
    required final CodeWriter codeWriter,
    required final ConstructorDeclaration? constructor,
    required final List<DeclarationInfo> fields,
    required final String generatedClassName,
    final bool shouldAnnotateFieldsWithOverride = true,
    final String? superConstructorName,
    required bool generateUnmodifiableCollections,
  })  : _codeWriter = codeWriter,
        _constructor = constructor,
        _fields = fields,
        _generatedClassName = generatedClassName,
        _shouldAnnotateFieldsWithOverride = shouldAnnotateFieldsWithOverride,
        _superConstructorName = superConstructorName,
        _generateUnmodifiableCollections = generateUnmodifiableCollections;

  final CodeWriter _codeWriter;
  final ConstructorDeclaration? _constructor;
  final List<DeclarationInfo> _fields;
  final String _generatedClassName;
  final bool _shouldAnnotateFieldsWithOverride;
  final String? _superConstructorName;
  final bool _generateUnmodifiableCollections;

  @override
  void execute() {
    final List<String> unmodifiableCollectionsDeclarations = <String>[];

    _codeWriter.write(_constructor?.constKeyword?.lexeme ?? '');
    _codeWriter.write(' $_generatedClassName(');

    final List<DeclarationInfo> positionalFields =
        _fields.where((DeclarationInfo element) => element.isPositional).toList(growable: false);

    final List<DeclarationInfo> namedFields =
        _fields.where((DeclarationInfo element) => element.isNamed).toList(growable: false);

    for (final DeclarationInfo field in positionalFields) {
      final CustomDartType customDartType = field.type.customDartType;

      if (_generateUnmodifiableCollections && customDartType.isCollection) {
        _codeWriter.write('${customDartType.fullTypeName} ${field.name},');
        unmodifiableCollectionsDeclarations.add('_${field.name} = ${field.name}');
      } else {
        _codeWriter.write('this.${field.name},');
      }
    }

    if (namedFields.isNotEmpty) {
      _codeWriter.write('{');
      for (final DeclarationInfo field in namedFields) {
        final Annotation? defaultValueAnnotation = field.metadata
            .firstWhereOrNull((Annotation annotation) => annotation.isDefaultValueAnnotation);
        final CustomDartType customDartType = field.type.customDartType;

        Expression? defaultValueExpression;
        late String defaultValuePrefix;

        if (defaultValueAnnotation != null) {
          final AnnotationValueExtractor annotationValueExtractor =
              AnnotationValueExtractor(defaultValueAnnotation);
          defaultValueExpression = annotationValueExtractor.getPositionedArgument(0);
        }
        defaultValuePrefix =
            (defaultValueExpression is TypedLiteral || defaultValueExpression is MethodInvocation)
                ? 'const'
                : '';

        if (field.isRequired) {
          _codeWriter.write('required ');
        }

        if (_generateUnmodifiableCollections && customDartType.isCollection) {
          _codeWriter.write(customDartType.fullTypeName);
        } else {
          _codeWriter.write('this.');
        }

        _codeWriter.write(field.name);

        if (defaultValueExpression != null) {
          _codeWriter.write(' = $defaultValuePrefix ${defaultValueExpression.toSource()}');
        }

        if (customDartType.isCollection && _generateUnmodifiableCollections) {
          unmodifiableCollectionsDeclarations.add('_${field.name} = ${field.name}');
        }

        _codeWriter.write(',');
      }
      _codeWriter.write('}');
    }

    if (unmodifiableCollectionsDeclarations.isNotEmpty) {
      _codeWriter
        ..write('): ')
        ..write(unmodifiableCollectionsDeclarations.join(', '))
        ..writeln(', super.${_superConstructorName ?? 'ctor'}()')
        ..writeln(';');
    } else {
      _codeWriter.writeln('): super.${_superConstructorName ?? 'ctor'}();');
    }

    _codeWriter.writeln();

    for (final DeclarationInfo field in _fields) {
      final CustomDartType customDartType = field.type.customDartType;

      if (_generateUnmodifiableCollections && customDartType.isCollection) {
        _codeWriter
          ..writeln()
          ..writeln(_shouldAnnotateFieldsWithOverride ? '@override' : '')
          ..write('${customDartType.fullTypeName} get ${field.name} => ');

        if (customDartType.isNullable) {
          final String notNullableType =
              customDartType.fullTypeName.substring(0, customDartType.fullTypeName.length - 1);
          _codeWriter.write('_${field.name} ?? $notNullableType.unmodifiable(_${field.name}!);');
        } else {
          _codeWriter.writeln('${customDartType.fullTypeName}.unmodifiable(_${field.name});');
        }

        _codeWriter
          ..writeln('final ${customDartType.fullTypeName} _${field.name};')
          ..writeln();
        continue;
      }

      _codeWriter
        ..writeln(_shouldAnnotateFieldsWithOverride ? '@override' : '')
        ..writeln('final ${customDartType.fullTypeName} ${field.name};')
        ..writeln();
    }

    _codeWriter.writeln();
  }
}
