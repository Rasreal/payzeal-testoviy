import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'top_institutions_record.g.dart';

abstract class TopInstitutionsRecord
    implements Built<TopInstitutionsRecord, TopInstitutionsRecordBuilder> {
  static Serializer<TopInstitutionsRecord> get serializer =>
      _$topInstitutionsRecordSerializer;

  String? get name;

  BuiltList<String>? get features;

  String? get id;

  String? get logo;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TopInstitutionsRecordBuilder builder) =>
      builder
        ..name = ''
        ..features = ListBuilder()
        ..id = ''
        ..logo = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('top_Institutions');

  static Stream<TopInstitutionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TopInstitutionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TopInstitutionsRecord._();
  factory TopInstitutionsRecord(
          [void Function(TopInstitutionsRecordBuilder) updates]) =
      _$TopInstitutionsRecord;

  static TopInstitutionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTopInstitutionsRecordData({
  String? name,
  String? id,
  String? logo,
}) {
  final firestoreData = serializers.toFirestore(
    TopInstitutionsRecord.serializer,
    TopInstitutionsRecord(
      (t) => t
        ..name = name
        ..features = null
        ..id = id
        ..logo = logo,
    ),
  );

  return firestoreData;
}
