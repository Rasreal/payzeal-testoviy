import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_friends_record.g.dart';

abstract class UserFriendsRecord
    implements Built<UserFriendsRecord, UserFriendsRecordBuilder> {
  static Serializer<UserFriendsRecord> get serializer =>
      _$userFriendsRecordSerializer;

  @BuiltValueField(wireName: 'UserReference')
  DocumentReference? get userReference;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(UserFriendsRecordBuilder builder) => builder;

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('UserFriends')
          : FirebaseFirestore.instance.collectionGroup('UserFriends');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('UserFriends').doc();

  static Stream<UserFriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UserFriendsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UserFriendsRecord._();
  factory UserFriendsRecord([void Function(UserFriendsRecordBuilder) updates]) =
      _$UserFriendsRecord;

  static UserFriendsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUserFriendsRecordData({
  DocumentReference? userReference,
}) {
  final firestoreData = serializers.toFirestore(
    UserFriendsRecord.serializer,
    UserFriendsRecord(
      (u) => u..userReference = userReference,
    ),
  );

  return firestoreData;
}
