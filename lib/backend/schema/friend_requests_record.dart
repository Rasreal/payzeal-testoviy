import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'friend_requests_record.g.dart';

abstract class FriendRequestsRecord
    implements Built<FriendRequestsRecord, FriendRequestsRecordBuilder> {
  static Serializer<FriendRequestsRecord> get serializer =>
      _$friendRequestsRecordSerializer;

  @BuiltValueField(wireName: 'UserReference')
  DocumentReference? get userReference;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(FriendRequestsRecordBuilder builder) =>
      builder;

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('FriendRequests')
          : FirebaseFirestore.instance.collectionGroup('FriendRequests');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('FriendRequests').doc();

  static Stream<FriendRequestsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<FriendRequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  FriendRequestsRecord._();
  factory FriendRequestsRecord(
          [void Function(FriendRequestsRecordBuilder) updates]) =
      _$FriendRequestsRecord;

  static FriendRequestsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createFriendRequestsRecordData({
  DocumentReference? userReference,
}) {
  final firestoreData = serializers.toFirestore(
    FriendRequestsRecord.serializer,
    FriendRequestsRecord(
      (f) => f..userReference = userReference,
    ),
  );

  return firestoreData;
}
