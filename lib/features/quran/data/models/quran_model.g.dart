// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuranSurahCollection on Isar {
  IsarCollection<QuranSurah> get quranSurahs => this.collection();
}

const QuranSurahSchema = CollectionSchema(
  name: r'QuranSurah',
  id: 1345877706402305948,
  properties: {
    r'nameAr': PropertySchema(
      id: 0,
      name: r'nameAr',
      type: IsarType.string,
    ),
    r'nameEn': PropertySchema(
      id: 1,
      name: r'nameEn',
      type: IsarType.string,
    ),
    r'number': PropertySchema(
      id: 2,
      name: r'number',
      type: IsarType.long,
    ),
    r'revelationOrder': PropertySchema(
      id: 3,
      name: r'revelationOrder',
      type: IsarType.long,
    ),
    r'totalVerses': PropertySchema(
      id: 4,
      name: r'totalVerses',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 5,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _quranSurahEstimateSize,
  serialize: _quranSurahSerialize,
  deserialize: _quranSurahDeserialize,
  deserializeProp: _quranSurahDeserializeProp,
  idName: r'id',
  indexes: {
    r'number': IndexSchema(
      id: 5012388430481709372,
      name: r'number',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'number',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'ayahs': LinkSchema(
      id: 2275347982438373187,
      name: r'ayahs',
      target: r'QuranAyah',
      single: false,
      linkName: r'surah',
    )
  },
  embeddedSchemas: {},
  getId: _quranSurahGetId,
  getLinks: _quranSurahGetLinks,
  attach: _quranSurahAttach,
  version: '3.1.0+1',
);

int _quranSurahEstimateSize(
  QuranSurah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nameAr.length * 3;
  bytesCount += 3 + object.nameEn.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _quranSurahSerialize(
  QuranSurah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.nameAr);
  writer.writeString(offsets[1], object.nameEn);
  writer.writeLong(offsets[2], object.number);
  writer.writeLong(offsets[3], object.revelationOrder);
  writer.writeLong(offsets[4], object.totalVerses);
  writer.writeString(offsets[5], object.type);
}

QuranSurah _quranSurahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuranSurah();
  object.id = id;
  object.nameAr = reader.readString(offsets[0]);
  object.nameEn = reader.readString(offsets[1]);
  object.number = reader.readLong(offsets[2]);
  object.revelationOrder = reader.readLongOrNull(offsets[3]);
  object.totalVerses = reader.readLong(offsets[4]);
  object.type = reader.readString(offsets[5]);
  return object;
}

P _quranSurahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quranSurahGetId(QuranSurah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quranSurahGetLinks(QuranSurah object) {
  return [object.ayahs];
}

void _quranSurahAttach(IsarCollection<dynamic> col, Id id, QuranSurah object) {
  object.id = id;
  object.ayahs.attach(col, col.isar.collection<QuranAyah>(), r'ayahs', id);
}

extension QuranSurahByIndex on IsarCollection<QuranSurah> {
  Future<QuranSurah?> getByNumber(int number) {
    return getByIndex(r'number', [number]);
  }

  QuranSurah? getByNumberSync(int number) {
    return getByIndexSync(r'number', [number]);
  }

  Future<bool> deleteByNumber(int number) {
    return deleteByIndex(r'number', [number]);
  }

  bool deleteByNumberSync(int number) {
    return deleteByIndexSync(r'number', [number]);
  }

  Future<List<QuranSurah?>> getAllByNumber(List<int> numberValues) {
    final values = numberValues.map((e) => [e]).toList();
    return getAllByIndex(r'number', values);
  }

  List<QuranSurah?> getAllByNumberSync(List<int> numberValues) {
    final values = numberValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'number', values);
  }

  Future<int> deleteAllByNumber(List<int> numberValues) {
    final values = numberValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'number', values);
  }

  int deleteAllByNumberSync(List<int> numberValues) {
    final values = numberValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'number', values);
  }

  Future<Id> putByNumber(QuranSurah object) {
    return putByIndex(r'number', object);
  }

  Id putByNumberSync(QuranSurah object, {bool saveLinks = true}) {
    return putByIndexSync(r'number', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNumber(List<QuranSurah> objects) {
    return putAllByIndex(r'number', objects);
  }

  List<Id> putAllByNumberSync(List<QuranSurah> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'number', objects, saveLinks: saveLinks);
  }
}

extension QuranSurahQueryWhereSort
    on QueryBuilder<QuranSurah, QuranSurah, QWhere> {
  QueryBuilder<QuranSurah, QuranSurah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhere> anyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'number'),
      );
    });
  }
}

extension QuranSurahQueryWhere
    on QueryBuilder<QuranSurah, QuranSurah, QWhereClause> {
  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> numberEqualTo(
      int number) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'number',
        value: [number],
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> numberNotEqualTo(
      int number) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [],
              upper: [number],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [number],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [number],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [],
              upper: [number],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> numberGreaterThan(
    int number, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [number],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> numberLessThan(
    int number, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [],
        upper: [number],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterWhereClause> numberBetween(
    int lowerNumber,
    int upperNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [lowerNumber],
        includeLower: includeLower,
        upper: [upperNumber],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuranSurahQueryFilter
    on QueryBuilder<QuranSurah, QuranSurah, QFilterCondition> {
  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameAr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameAr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameAr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameAr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameAr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameAr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameAr',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameAr',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameArIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameAr',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      nameArIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameAr',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameEn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameEn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> nameEnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameEn',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      nameEnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameEn',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> numberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> numberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> numberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> numberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      revelationOrderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'revelationOrder',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      revelationOrderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'revelationOrder',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      revelationOrderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'revelationOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      revelationOrderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'revelationOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      revelationOrderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'revelationOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      revelationOrderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'revelationOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      totalVersesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalVerses',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      totalVersesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalVerses',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      totalVersesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalVerses',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      totalVersesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalVerses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension QuranSurahQueryObject
    on QueryBuilder<QuranSurah, QuranSurah, QFilterCondition> {}

extension QuranSurahQueryLinks
    on QueryBuilder<QuranSurah, QuranSurah, QFilterCondition> {
  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> ayahs(
      FilterQuery<QuranAyah> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ayahs');
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      ayahsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayahs', length, true, length, true);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition> ayahsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayahs', 0, true, 0, true);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      ayahsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayahs', 0, false, 999999, true);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      ayahsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayahs', 0, true, length, include);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      ayahsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayahs', length, include, 999999, true);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterFilterCondition>
      ayahsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'ayahs', lower, includeLower, upper, includeUpper);
    });
  }
}

extension QuranSurahQuerySortBy
    on QueryBuilder<QuranSurah, QuranSurah, QSortBy> {
  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByNameAr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameAr', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByNameArDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameAr', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByNameEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameEn', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByNameEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameEn', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByRevelationOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationOrder', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy>
      sortByRevelationOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationOrder', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByTotalVerses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVerses', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByTotalVersesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVerses', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension QuranSurahQuerySortThenBy
    on QueryBuilder<QuranSurah, QuranSurah, QSortThenBy> {
  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByNameAr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameAr', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByNameArDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameAr', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByNameEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameEn', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByNameEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameEn', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByRevelationOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationOrder', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy>
      thenByRevelationOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationOrder', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByTotalVerses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVerses', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByTotalVersesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVerses', Sort.desc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension QuranSurahQueryWhereDistinct
    on QueryBuilder<QuranSurah, QuranSurah, QDistinct> {
  QueryBuilder<QuranSurah, QuranSurah, QDistinct> distinctByNameAr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameAr', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QDistinct> distinctByNameEn(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameEn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QDistinct> distinctByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'number');
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QDistinct> distinctByRevelationOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'revelationOrder');
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QDistinct> distinctByTotalVerses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalVerses');
    });
  }

  QueryBuilder<QuranSurah, QuranSurah, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension QuranSurahQueryProperty
    on QueryBuilder<QuranSurah, QuranSurah, QQueryProperty> {
  QueryBuilder<QuranSurah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuranSurah, String, QQueryOperations> nameArProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameAr');
    });
  }

  QueryBuilder<QuranSurah, String, QQueryOperations> nameEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameEn');
    });
  }

  QueryBuilder<QuranSurah, int, QQueryOperations> numberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'number');
    });
  }

  QueryBuilder<QuranSurah, int?, QQueryOperations> revelationOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'revelationOrder');
    });
  }

  QueryBuilder<QuranSurah, int, QQueryOperations> totalVersesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalVerses');
    });
  }

  QueryBuilder<QuranSurah, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuranAyahCollection on Isar {
  IsarCollection<QuranAyah> get quranAyahs => this.collection();
}

const QuranAyahSchema = CollectionSchema(
  name: r'QuranAyah',
  id: -5788100502552865987,
  properties: {
    r'numberInSurah': PropertySchema(
      id: 0,
      name: r'numberInSurah',
      type: IsarType.long,
    ),
    r'pageNumber': PropertySchema(
      id: 1,
      name: r'pageNumber',
      type: IsarType.long,
    ),
    r'surahNumber': PropertySchema(
      id: 2,
      name: r'surahNumber',
      type: IsarType.long,
    ),
    r'text': PropertySchema(
      id: 3,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _quranAyahEstimateSize,
  serialize: _quranAyahSerialize,
  deserialize: _quranAyahDeserialize,
  deserializeProp: _quranAyahDeserializeProp,
  idName: r'id',
  indexes: {
    r'surahNumber': IndexSchema(
      id: 9024003441292455669,
      name: r'surahNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'surahNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'pageNumber': IndexSchema(
      id: -702571354938573130,
      name: r'pageNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'pageNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'surah': LinkSchema(
      id: -4585789110518535987,
      name: r'surah',
      target: r'QuranSurah',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _quranAyahGetId,
  getLinks: _quranAyahGetLinks,
  attach: _quranAyahAttach,
  version: '3.1.0+1',
);

int _quranAyahEstimateSize(
  QuranAyah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _quranAyahSerialize(
  QuranAyah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.numberInSurah);
  writer.writeLong(offsets[1], object.pageNumber);
  writer.writeLong(offsets[2], object.surahNumber);
  writer.writeString(offsets[3], object.text);
}

QuranAyah _quranAyahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuranAyah();
  object.id = id;
  object.numberInSurah = reader.readLong(offsets[0]);
  object.pageNumber = reader.readLong(offsets[1]);
  object.surahNumber = reader.readLong(offsets[2]);
  object.text = reader.readString(offsets[3]);
  return object;
}

P _quranAyahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quranAyahGetId(QuranAyah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quranAyahGetLinks(QuranAyah object) {
  return [object.surah];
}

void _quranAyahAttach(IsarCollection<dynamic> col, Id id, QuranAyah object) {
  object.id = id;
  object.surah.attach(col, col.isar.collection<QuranSurah>(), r'surah', id);
}

extension QuranAyahQueryWhereSort
    on QueryBuilder<QuranAyah, QuranAyah, QWhere> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhere> anySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'surahNumber'),
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhere> anyPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'pageNumber'),
      );
    });
  }
}

extension QuranAyahQueryWhere
    on QueryBuilder<QuranAyah, QuranAyah, QWhereClause> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberEqualTo(
      int surahNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'surahNumber',
        value: [surahNumber],
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberNotEqualTo(
      int surahNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [],
              upper: [surahNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [surahNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [surahNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [],
              upper: [surahNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberGreaterThan(
    int surahNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumber',
        lower: [surahNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberLessThan(
    int surahNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumber',
        lower: [],
        upper: [surahNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> surahNumberBetween(
    int lowerSurahNumber,
    int upperSurahNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumber',
        lower: [lowerSurahNumber],
        includeLower: includeLower,
        upper: [upperSurahNumber],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> pageNumberEqualTo(
      int pageNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pageNumber',
        value: [pageNumber],
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> pageNumberNotEqualTo(
      int pageNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pageNumber',
              lower: [],
              upper: [pageNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pageNumber',
              lower: [pageNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pageNumber',
              lower: [pageNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pageNumber',
              lower: [],
              upper: [pageNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> pageNumberGreaterThan(
    int pageNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pageNumber',
        lower: [pageNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> pageNumberLessThan(
    int pageNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pageNumber',
        lower: [],
        upper: [pageNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterWhereClause> pageNumberBetween(
    int lowerPageNumber,
    int upperPageNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pageNumber',
        lower: [lowerPageNumber],
        includeLower: includeLower,
        upper: [upperPageNumber],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuranAyahQueryFilter
    on QueryBuilder<QuranAyah, QuranAyah, QFilterCondition> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      numberInSurahEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numberInSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      numberInSurahGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numberInSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      numberInSurahLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numberInSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      numberInSurahBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numberInSurah',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> pageNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      pageNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> pageNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> pageNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition>
      surahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension QuranAyahQueryObject
    on QueryBuilder<QuranAyah, QuranAyah, QFilterCondition> {}

extension QuranAyahQueryLinks
    on QueryBuilder<QuranAyah, QuranAyah, QFilterCondition> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surah(
      FilterQuery<QuranSurah> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'surah');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterFilterCondition> surahIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'surah', 0, true, 0, true);
    });
  }
}

extension QuranAyahQuerySortBy on QueryBuilder<QuranAyah, QuranAyah, QSortBy> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByNumberInSurahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension QuranAyahQuerySortThenBy
    on QueryBuilder<QuranAyah, QuranAyah, QSortThenBy> {
  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByNumberInSurahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension QuranAyahQueryWhereDistinct
    on QueryBuilder<QuranAyah, QuranAyah, QDistinct> {
  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberInSurah');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageNumber');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNumber');
    });
  }

  QueryBuilder<QuranAyah, QuranAyah, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension QuranAyahQueryProperty
    on QueryBuilder<QuranAyah, QuranAyah, QQueryProperty> {
  QueryBuilder<QuranAyah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuranAyah, int, QQueryOperations> numberInSurahProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberInSurah');
    });
  }

  QueryBuilder<QuranAyah, int, QQueryOperations> pageNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageNumber');
    });
  }

  QueryBuilder<QuranAyah, int, QQueryOperations> surahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNumber');
    });
  }

  QueryBuilder<QuranAyah, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuranTafseerCollection on Isar {
  IsarCollection<QuranTafseer> get quranTafseers => this.collection();
}

const QuranTafseerSchema = CollectionSchema(
  name: r'QuranTafseer',
  id: 6908611274471459622,
  properties: {
    r'ayahNumber': PropertySchema(
      id: 0,
      name: r'ayahNumber',
      type: IsarType.long,
    ),
    r'edition': PropertySchema(
      id: 1,
      name: r'edition',
      type: IsarType.string,
    ),
    r'surahNumber': PropertySchema(
      id: 2,
      name: r'surahNumber',
      type: IsarType.long,
    ),
    r'text': PropertySchema(
      id: 3,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _quranTafseerEstimateSize,
  serialize: _quranTafseerSerialize,
  deserialize: _quranTafseerDeserialize,
  deserializeProp: _quranTafseerDeserializeProp,
  idName: r'id',
  indexes: {
    r'surahNumber': IndexSchema(
      id: 9024003441292455669,
      name: r'surahNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'surahNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'ayahNumber': IndexSchema(
      id: -8135434729161833584,
      name: r'ayahNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ayahNumber',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'ayah': LinkSchema(
      id: 9118819452146177002,
      name: r'ayah',
      target: r'QuranAyah',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _quranTafseerGetId,
  getLinks: _quranTafseerGetLinks,
  attach: _quranTafseerAttach,
  version: '3.1.0+1',
);

int _quranTafseerEstimateSize(
  QuranTafseer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.edition.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _quranTafseerSerialize(
  QuranTafseer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.ayahNumber);
  writer.writeString(offsets[1], object.edition);
  writer.writeLong(offsets[2], object.surahNumber);
  writer.writeString(offsets[3], object.text);
}

QuranTafseer _quranTafseerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuranTafseer();
  object.ayahNumber = reader.readLong(offsets[0]);
  object.edition = reader.readString(offsets[1]);
  object.id = id;
  object.surahNumber = reader.readLong(offsets[2]);
  object.text = reader.readString(offsets[3]);
  return object;
}

P _quranTafseerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quranTafseerGetId(QuranTafseer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quranTafseerGetLinks(QuranTafseer object) {
  return [object.ayah];
}

void _quranTafseerAttach(
    IsarCollection<dynamic> col, Id id, QuranTafseer object) {
  object.id = id;
  object.ayah.attach(col, col.isar.collection<QuranAyah>(), r'ayah', id);
}

extension QuranTafseerQueryWhereSort
    on QueryBuilder<QuranTafseer, QuranTafseer, QWhere> {
  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhere> anySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'surahNumber'),
      );
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhere> anyAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'ayahNumber'),
      );
    });
  }
}

extension QuranTafseerQueryWhere
    on QueryBuilder<QuranTafseer, QuranTafseer, QWhereClause> {
  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      surahNumberEqualTo(int surahNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'surahNumber',
        value: [surahNumber],
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      surahNumberNotEqualTo(int surahNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [],
              upper: [surahNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [surahNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [surahNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'surahNumber',
              lower: [],
              upper: [surahNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      surahNumberGreaterThan(
    int surahNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumber',
        lower: [surahNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      surahNumberLessThan(
    int surahNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumber',
        lower: [],
        upper: [surahNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      surahNumberBetween(
    int lowerSurahNumber,
    int upperSurahNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'surahNumber',
        lower: [lowerSurahNumber],
        includeLower: includeLower,
        upper: [upperSurahNumber],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> ayahNumberEqualTo(
      int ayahNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ayahNumber',
        value: [ayahNumber],
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      ayahNumberNotEqualTo(int ayahNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahNumber',
              lower: [],
              upper: [ayahNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahNumber',
              lower: [ayahNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahNumber',
              lower: [ayahNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahNumber',
              lower: [],
              upper: [ayahNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      ayahNumberGreaterThan(
    int ayahNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahNumber',
        lower: [ayahNumber],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause>
      ayahNumberLessThan(
    int ayahNumber, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahNumber',
        lower: [],
        upper: [ayahNumber],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterWhereClause> ayahNumberBetween(
    int lowerAyahNumber,
    int upperAyahNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahNumber',
        lower: [lowerAyahNumber],
        includeLower: includeLower,
        upper: [upperAyahNumber],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuranTafseerQueryFilter
    on QueryBuilder<QuranTafseer, QuranTafseer, QFilterCondition> {
  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      ayahNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      ayahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ayahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      ayahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ayahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      ayahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ayahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'edition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'edition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'edition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'edition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'edition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'edition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'edition',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'edition',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      editionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'edition',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      surahNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      surahNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      surahNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surahNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      surahNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surahNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension QuranTafseerQueryObject
    on QueryBuilder<QuranTafseer, QuranTafseer, QFilterCondition> {}

extension QuranTafseerQueryLinks
    on QueryBuilder<QuranTafseer, QuranTafseer, QFilterCondition> {
  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> ayah(
      FilterQuery<QuranAyah> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'ayah');
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterFilterCondition> ayahIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'ayah', 0, true, 0, true);
    });
  }
}

extension QuranTafseerQuerySortBy
    on QueryBuilder<QuranTafseer, QuranTafseer, QSortBy> {
  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> sortByAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy>
      sortByAyahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> sortByEdition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edition', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> sortByEditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edition', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> sortBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy>
      sortBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension QuranTafseerQuerySortThenBy
    on QueryBuilder<QuranTafseer, QuranTafseer, QSortThenBy> {
  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenByAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy>
      thenByAyahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ayahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenByEdition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edition', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenByEditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'edition', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy>
      thenBySurahNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'surahNumber', Sort.desc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension QuranTafseerQueryWhereDistinct
    on QueryBuilder<QuranTafseer, QuranTafseer, QDistinct> {
  QueryBuilder<QuranTafseer, QuranTafseer, QDistinct> distinctByAyahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayahNumber');
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QDistinct> distinctByEdition(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'edition', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QDistinct> distinctBySurahNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'surahNumber');
    });
  }

  QueryBuilder<QuranTafseer, QuranTafseer, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension QuranTafseerQueryProperty
    on QueryBuilder<QuranTafseer, QuranTafseer, QQueryProperty> {
  QueryBuilder<QuranTafseer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuranTafseer, int, QQueryOperations> ayahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayahNumber');
    });
  }

  QueryBuilder<QuranTafseer, String, QQueryOperations> editionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'edition');
    });
  }

  QueryBuilder<QuranTafseer, int, QQueryOperations> surahNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'surahNumber');
    });
  }

  QueryBuilder<QuranTafseer, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
