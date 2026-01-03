import 'package:isar/isar.dart';

part 'adhkar_model.g.dart';

@collection
class DhikrCategory {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name; // Morning, Evening, etc.

  final items = IsarLinks<DhikrItem>();
}

@collection
class DhikrItem {
  Id id = Isar.autoIncrement;

  late String text;
  late String reference; // e.g., Muslim, Bukhari

  int targetCount = 1;
  int currentCount = 0; // For tracking progress

  String? audioUrl;
  String? virtue; // Fadila (Reward/Benefit)
  String? description;

  bool isFavorite = false;

  // Relationships
  @Backlink(to: 'items')
  final category = IsarLink<DhikrCategory>();
}
