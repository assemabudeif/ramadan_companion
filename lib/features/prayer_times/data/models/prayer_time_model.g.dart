// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_time_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPrayerTimeModelCollection on Isar {
  IsarCollection<PrayerTimeModel> get prayerTimeModels => this.collection();
}

const PrayerTimeModelSchema = CollectionSchema(
  name: r'PrayerTimeModel',
  id: 2825715766265611621,
  properties: {
    r'asr': PropertySchema(
      id: 0,
      name: r'asr',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'dhuhr': PropertySchema(
      id: 2,
      name: r'dhuhr',
      type: IsarType.dateTime,
    ),
    r'fajr': PropertySchema(
      id: 3,
      name: r'fajr',
      type: IsarType.dateTime,
    ),
    r'hijriDate': PropertySchema(
      id: 4,
      name: r'hijriDate',
      type: IsarType.string,
    ),
    r'isha': PropertySchema(
      id: 5,
      name: r'isha',
      type: IsarType.dateTime,
    ),
    r'maghrib': PropertySchema(
      id: 6,
      name: r'maghrib',
      type: IsarType.dateTime,
    ),
    r'sunrise': PropertySchema(
      id: 7,
      name: r'sunrise',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _prayerTimeModelEstimateSize,
  serialize: _prayerTimeModelSerialize,
  deserialize: _prayerTimeModelDeserialize,
  deserializeProp: _prayerTimeModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _prayerTimeModelGetId,
  getLinks: _prayerTimeModelGetLinks,
  attach: _prayerTimeModelAttach,
  version: '3.1.0+1',
);

int _prayerTimeModelEstimateSize(
  PrayerTimeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.hijriDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _prayerTimeModelSerialize(
  PrayerTimeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.asr);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDateTime(offsets[2], object.dhuhr);
  writer.writeDateTime(offsets[3], object.fajr);
  writer.writeString(offsets[4], object.hijriDate);
  writer.writeDateTime(offsets[5], object.isha);
  writer.writeDateTime(offsets[6], object.maghrib);
  writer.writeDateTime(offsets[7], object.sunrise);
}

PrayerTimeModel _prayerTimeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PrayerTimeModel();
  object.asr = reader.readDateTime(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.dhuhr = reader.readDateTime(offsets[2]);
  object.fajr = reader.readDateTime(offsets[3]);
  object.hijriDate = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.isha = reader.readDateTime(offsets[5]);
  object.maghrib = reader.readDateTime(offsets[6]);
  object.sunrise = reader.readDateTime(offsets[7]);
  return object;
}

P _prayerTimeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _prayerTimeModelGetId(PrayerTimeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _prayerTimeModelGetLinks(PrayerTimeModel object) {
  return [];
}

void _prayerTimeModelAttach(
    IsarCollection<dynamic> col, Id id, PrayerTimeModel object) {
  object.id = id;
}

extension PrayerTimeModelByIndex on IsarCollection<PrayerTimeModel> {
  Future<PrayerTimeModel?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  PrayerTimeModel? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<PrayerTimeModel?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<PrayerTimeModel?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(PrayerTimeModel object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(PrayerTimeModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<PrayerTimeModel> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<PrayerTimeModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension PrayerTimeModelQueryWhereSort
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QWhere> {
  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension PrayerTimeModelQueryWhere
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QWhereClause> {
  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause>
      dateNotEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause>
      dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause>
      dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PrayerTimeModelQueryFilter
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QFilterCondition> {
  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      asrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'asr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      asrGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'asr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      asrLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'asr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      asrBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'asr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dhuhrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dhuhr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dhuhrGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dhuhr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dhuhrLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dhuhr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      dhuhrBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dhuhr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      fajrEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fajr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      fajrGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fajr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      fajrLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fajr',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      fajrBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fajr',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hijriDate',
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hijriDate',
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hijriDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hijriDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hijriDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hijriDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hijriDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hijriDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hijriDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hijriDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hijriDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      hijriDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hijriDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      ishaEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isha',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      ishaGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isha',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      ishaLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isha',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      ishaBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isha',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      maghribEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maghrib',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      maghribGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maghrib',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      maghribLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maghrib',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      maghribBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maghrib',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      sunriseEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunrise',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      sunriseGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sunrise',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      sunriseLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sunrise',
        value: value,
      ));
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterFilterCondition>
      sunriseBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sunrise',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PrayerTimeModelQueryObject
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QFilterCondition> {}

extension PrayerTimeModelQueryLinks
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QFilterCondition> {}

extension PrayerTimeModelQuerySortBy
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QSortBy> {
  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByAsr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByAsrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByDhuhr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByDhuhrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByFajr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByFajrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByHijriDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hijriDate', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByHijriDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hijriDate', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByIsha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByIshaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortByMaghrib() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortByMaghribDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> sortBySunrise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      sortBySunriseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.desc);
    });
  }
}

extension PrayerTimeModelQuerySortThenBy
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QSortThenBy> {
  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByAsr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByAsrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'asr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByDhuhr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByDhuhrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhuhr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByFajr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByFajrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fajr', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByHijriDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hijriDate', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByHijriDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hijriDate', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByIsha() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByIshaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isha', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenByMaghrib() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenByMaghribDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maghrib', Sort.desc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy> thenBySunrise() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.asc);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QAfterSortBy>
      thenBySunriseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sunrise', Sort.desc);
    });
  }
}

extension PrayerTimeModelQueryWhereDistinct
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> {
  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> distinctByAsr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'asr');
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> distinctByDhuhr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dhuhr');
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> distinctByFajr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fajr');
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> distinctByHijriDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hijriDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct> distinctByIsha() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isha');
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct>
      distinctByMaghrib() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maghrib');
    });
  }

  QueryBuilder<PrayerTimeModel, PrayerTimeModel, QDistinct>
      distinctBySunrise() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sunrise');
    });
  }
}

extension PrayerTimeModelQueryProperty
    on QueryBuilder<PrayerTimeModel, PrayerTimeModel, QQueryProperty> {
  QueryBuilder<PrayerTimeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> asrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'asr');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> dhuhrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dhuhr');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> fajrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fajr');
    });
  }

  QueryBuilder<PrayerTimeModel, String?, QQueryOperations> hijriDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hijriDate');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> ishaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isha');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> maghribProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maghrib');
    });
  }

  QueryBuilder<PrayerTimeModel, DateTime, QQueryOperations> sunriseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sunrise');
    });
  }
}
