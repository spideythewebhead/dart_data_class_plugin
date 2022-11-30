import 'package:data_class_plugin/data_class_plugin.dart';

@Enum()
enum Category {
  science(1),
  finance(2),
  music(3),
  tech(4);

  /// Default constructor of [Category]
  const Category(this.id);

  final int id;
}

// Should generate the default methods of the annotation
