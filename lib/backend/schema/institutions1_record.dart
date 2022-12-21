import 'dart:async';

import 'package:from_css_color/from_css_color.dart';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'institutions1_record.g.dart';

abstract class Institutions1Record
    implements Built<Institutions1Record, Institutions1RecordBuilder> {
  static Serializer<Institutions1Record> get serializer =>
      _$institutions1RecordSerializer;

  String? get name;

  String? get id;

  BuiltList<String>? get features;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(Institutions1RecordBuilder builder) => builder
    ..name = ''
    ..id = ''
    ..features = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Institutions1');

  static Stream<Institutions1Record> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<Institutions1Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Institutions1Record fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      Institutions1Record(
        (c) => c
          ..name = snapshot.data['name']
          ..id = snapshot.data['id']
          ..features = safeGet(() => ListBuilder(snapshot.data['features']))
          ..ffRef = Institutions1Record.collection.doc(snapshot.objectID),
      );

  static Future<List<Institutions1Record>> search(
          {String? term,
          FutureOr<LatLng>? location,
          int? maxResults,
          double? searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Institutions1',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  Institutions1Record._();
  factory Institutions1Record(
          [void Function(Institutions1RecordBuilder) updates]) =
      _$Institutions1Record;

  static Institutions1Record getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createInstitutions1RecordData({
  String? name,
  String? id,
}) {
  final firestoreData = serializers.toFirestore(
    Institutions1Record.serializer,
    Institutions1Record(
      (i) => i
        ..name = name
        ..id = id
        ..features = null,
    ),
  );

  return firestoreData;
}
