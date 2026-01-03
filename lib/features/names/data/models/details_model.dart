import 'package:isar/isar.dart';

part 'details_model.g.dart';

@collection
class NameOfAllah {
  Id id = Isar.autoIncrement;

  late String name;
  String? meaning; // If we have meanings later
}

// We can also have NameOfMohamed if needed, structure is identical
@collection
class NameOfMohamed {
  Id id = Isar.autoIncrement;

  late String name;
}
