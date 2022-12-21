import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'requests_record.g.dart';

abstract class RequestsRecord
    implements Built<RequestsRecord, RequestsRecordBuilder> {
  static Serializer<RequestsRecord> get serializer =>
      _$requestsRecordSerializer;

  @BuiltValueField(wireName: 'SenderReference')
  DocumentReference? get senderReference;

  @BuiltValueField(wireName: 'RecepientReference')
  DocumentReference? get recepientReference;

  @BuiltValueField(wireName: 'RequestTime')
  DateTime? get requestTime;

  @BuiltValueField(wireName: 'Comment')
  String? get comment;

  BuiltList<DocumentReference>? get usersInvolved;

  @BuiltValueField(wireName: 'Amount')
  String? get amount;

  @BuiltValueField(wireName: 'is_paid')
  bool? get isPaid;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(RequestsRecordBuilder builder) => builder
    ..comment = ''
    ..usersInvolved = ListBuilder()
    ..amount = ''
    ..isPaid = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Requests');

  static Stream<RequestsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<RequestsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  RequestsRecord._();
  factory RequestsRecord([void Function(RequestsRecordBuilder) updates]) =
      _$RequestsRecord;

  static RequestsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createRequestsRecordData({
  DocumentReference? senderReference,
  DocumentReference? recepientReference,
  DateTime? requestTime,
  String? comment,
  String? amount,
  bool? isPaid,
}) {
  final firestoreData = serializers.toFirestore(
    RequestsRecord.serializer,
    RequestsRecord(
      (r) => r
        ..senderReference = senderReference
        ..recepientReference = recepientReference
        ..requestTime = requestTime
        ..comment = comment
        ..usersInvolved = null
        ..amount = amount
        ..isPaid = isPaid,
    ),
  );

  return firestoreData;
}
