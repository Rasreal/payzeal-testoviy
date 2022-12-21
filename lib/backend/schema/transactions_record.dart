import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'transactions_record.g.dart';

abstract class TransactionsRecord
    implements Built<TransactionsRecord, TransactionsRecordBuilder> {
  static Serializer<TransactionsRecord> get serializer =>
      _$transactionsRecordSerializer;

  DateTime? get transactionTime;

  String? get comment;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: 'Transaction_Amount')
  int? get transactionAmount;

  DocumentReference? get sender;

  DocumentReference? get recipientReference;

  String? get uid;

  BuiltList<DocumentReference>? get isLikedBy;

  bool? get isPublic;

  LatLng? get transactionLocation;

  BuiltList<DocumentReference>? get usersInvolved;

  @BuiltValueField(wireName: 'transaction_picture')
  String? get transactionPicture;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TransactionsRecordBuilder builder) => builder
    ..comment = ''
    ..photoUrl = ''
    ..transactionAmount = 0
    ..uid = ''
    ..isLikedBy = ListBuilder()
    ..isPublic = false
    ..usersInvolved = ListBuilder()
    ..transactionPicture = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TransactionsRecord._();
  factory TransactionsRecord(
          [void Function(TransactionsRecordBuilder) updates]) =
      _$TransactionsRecord;

  static TransactionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTransactionsRecordData({
  DateTime? transactionTime,
  String? comment,
  String? photoUrl,
  DateTime? createdTime,
  int? transactionAmount,
  DocumentReference? sender,
  DocumentReference? recipientReference,
  String? uid,
  bool? isPublic,
  LatLng? transactionLocation,
  String? transactionPicture,
}) {
  final firestoreData = serializers.toFirestore(
    TransactionsRecord.serializer,
    TransactionsRecord(
      (t) => t
        ..transactionTime = transactionTime
        ..comment = comment
        ..photoUrl = photoUrl
        ..createdTime = createdTime
        ..transactionAmount = transactionAmount
        ..sender = sender
        ..recipientReference = recipientReference
        ..uid = uid
        ..isLikedBy = null
        ..isPublic = isPublic
        ..transactionLocation = transactionLocation
        ..usersInvolved = null
        ..transactionPicture = transactionPicture,
    ),
  );

  return firestoreData;
}
