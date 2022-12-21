import 'dart:async';

import 'package:from_css_color/from_css_color.dart';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  String? get email;

  String? get password;

  String? get uid;

  int? get age;

  LatLng? get location;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  String? get choosenInstitution;

  @BuiltValueField(wireName: 'IBAN')
  String? get iban;

  String? get realDisplayName;

  String? get countryCode;

  String? get typeAuth;

  String? get postCode;

  @BuiltValueField(wireName: 'UniTag')
  String? get uniTag;

  @BuiltValueField(wireName: 'FirstTransactionMade')
  bool? get firstTransactionMade;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..displayName = ''
    ..email = ''
    ..password = ''
    ..uid = ''
    ..age = 0
    ..phoneNumber = ''
    ..photoUrl = ''
    ..choosenInstitution = ''
    ..iban = ''
    ..realDisplayName = ''
    ..countryCode = ''
    ..typeAuth = ''
    ..postCode = ''
    ..uniTag = ''
    ..firstTransactionMade = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => UsersRecord(
        (c) => c
          ..displayName = snapshot.data['display_name']
          ..email = snapshot.data['email']
          ..password = snapshot.data['password']
          ..uid = snapshot.data['uid']
          ..age = snapshot.data['age']?.round()
          ..location = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..phoneNumber = snapshot.data['phone_number']
          ..photoUrl = snapshot.data['photo_url']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..choosenInstitution = snapshot.data['choosenInstitution']
          ..iban = snapshot.data['IBAN']
          ..realDisplayName = snapshot.data['realDisplayName']
          ..countryCode = snapshot.data['countryCode']
          ..typeAuth = snapshot.data['typeAuth']
          ..postCode = snapshot.data['postCode']
          ..uniTag = snapshot.data['UniTag']
          ..firstTransactionMade = snapshot.data['FirstTransactionMade']
          ..ffRef = UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search(
          {String? term,
          FutureOr<LatLng>? location,
          int? maxResults,
          double? searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUsersRecordData({
  String? displayName,
  String? email,
  String? password,
  String? uid,
  int? age,
  LatLng? location,
  String? phoneNumber,
  String? photoUrl,
  DateTime? createdTime,
  String? choosenInstitution,
  String? iban,
  String? realDisplayName,
  String? countryCode,
  String? typeAuth,
  String? postCode,
  String? uniTag,
  bool? firstTransactionMade,
}) {
  final firestoreData = serializers.toFirestore(
    UsersRecord.serializer,
    UsersRecord(
      (u) => u
        ..displayName = displayName
        ..email = email
        ..password = password
        ..uid = uid
        ..age = age
        ..location = location
        ..phoneNumber = phoneNumber
        ..photoUrl = photoUrl
        ..createdTime = createdTime
        ..choosenInstitution = choosenInstitution
        ..iban = iban
        ..realDisplayName = realDisplayName
        ..countryCode = countryCode
        ..typeAuth = typeAuth
        ..postCode = postCode
        ..uniTag = uniTag
        ..firstTransactionMade = firstTransactionMade,
    ),
  );

  return firestoreData;
}
