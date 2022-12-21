import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    _Contacts = (await secureStorage.getStringList('ff_Contacts'))
            ?.map((path) => path.ref)
            .toList() ??
        _Contacts;
    _emptyString =
        await secureStorage.getString('ff_emptyString') ?? _emptyString;
  }

  late FlutterSecureStorage secureStorage;

  String _Transactionrecepient = '-';
  String get Transactionrecepient => _Transactionrecepient;
  set Transactionrecepient(String _value) {
    notifyListeners();

    _Transactionrecepient = _value;
  }

  String _transrecepientimage =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png';
  String get transrecepientimage => _transrecepientimage;
  set transrecepientimage(String _value) {
    notifyListeners();

    _transrecepientimage = _value;
  }

  String _messageto = '-';
  String get messageto => _messageto;
  set messageto(String _value) {
    notifyListeners();

    _messageto = _value;
  }

  DocumentReference? _TransactionRecepient =
      FirebaseFirestore.instance.doc('/users/egor');
  DocumentReference? get TransactionRecepient => _TransactionRecepient;
  set TransactionRecepient(DocumentReference? _value) {
    notifyListeners();
    if (_value == null) {
      return;
    }
    _TransactionRecepient = _value;
  }

  List<DocumentReference> _Contacts = [
    FirebaseFirestore.instance.doc('/users/egor')
  ];
  List<DocumentReference> get Contacts => _Contacts;
  set Contacts(List<DocumentReference> _value) {
    notifyListeners();

    _Contacts = _value;
    secureStorage.setStringList(
        'ff_Contacts', _value.map((x) => x.path).toList());
  }

  void deleteContacts() {
    notifyListeners();
    secureStorage.delete(key: 'ff_Contacts');
  }

  void addToContacts(DocumentReference _value) {
    notifyListeners();
    _Contacts.add(_value);
    secureStorage.setStringList(
        'ff_Contacts', _Contacts.map((x) => x.path).toList());
  }

  void removeFromContacts(DocumentReference _value) {
    notifyListeners();
    _Contacts.remove(_value);
    secureStorage.setStringList(
        'ff_Contacts', _Contacts.map((x) => x.path).toList());
  }

  String _emptyString = '-';
  String get emptyString => _emptyString;
  set emptyString(String _value) {
    notifyListeners();

    _emptyString = _value;
    secureStorage.setString('ff_emptyString', _value);
  }

  void deleteEmptyString() {
    notifyListeners();
    secureStorage.delete(key: 'ff_emptyString');
  }

  String _indempotencyID = '-';
  String get indempotencyID => _indempotencyID;
  set indempotencyID(String _value) {
    notifyListeners();

    _indempotencyID = _value;
  }

  List<String> _Banks = ['Hello World'];
  List<String> get Banks => _Banks;
  set Banks(List<String> _value) {
    notifyListeners();

    _Banks = _value;
  }

  void addToBanks(String _value) {
    notifyListeners();
    _Banks.add(_value);
  }

  void removeFromBanks(String _value) {
    notifyListeners();
    _Banks.remove(_value);
  }

  List<String> _bankphotos = ['https://picsum.photos/seed/599/600'];
  List<String> get bankphotos => _bankphotos;
  set bankphotos(List<String> _value) {
    notifyListeners();

    _bankphotos = _value;
  }

  void addToBankphotos(String _value) {
    notifyListeners();
    _bankphotos.add(_value);
  }

  void removeFromBankphotos(String _value) {
    notifyListeners();
    _bankphotos.remove(_value);
  }

  String _SingleAuthFeature =
      '    \"ACCOUNT_TRANSACTIONS\",\n    \"ACCOUNT_REQUEST_DETAILS\",\n    \"INITIATE_ACCOUNT_REQUEST\",\n    \"INITIATE_ONETIME_PRE_AUTHORISATION_PAYMENTS\",\n    \"INITIATE_DOMESTIC_SCHEDULED_PAYMENT\",\n    \"EXISTING_PAYMENTS_DETAILS\",\n    \"INITIATE_DOMESTIC_SINGLE_PAYMENT\",\n    \"CREATE_DOMESTIC_SCHEDULED_PAYMENT\",\n    \"CREATE_DOMESTIC_SINGLE_PAYMENT\",\n    \"EXISTING_PAYMENT_INITIATION_DETAILS\",\n    \"ACCOUNT_BALANCES\"';
  String get SingleAuthFeature => _SingleAuthFeature;
  set SingleAuthFeature(String _value) {
    notifyListeners();

    _SingleAuthFeature = _value;
  }

  List<String> _InstitutionsIDs = ['Hello World'];
  List<String> get InstitutionsIDs => _InstitutionsIDs;
  set InstitutionsIDs(List<String> _value) {
    notifyListeners();

    _InstitutionsIDs = _value;
  }

  void addToInstitutionsIDs(String _value) {
    notifyListeners();
    _InstitutionsIDs.add(_value);
  }

  void removeFromInstitutionsIDs(String _value) {
    notifyListeners();
    _InstitutionsIDs.remove(_value);
  }

  List<dynamic> _getInstitutionsFullData = [jsonDecode('{}')];
  List<dynamic> get getInstitutionsFullData => _getInstitutionsFullData;
  set getInstitutionsFullData(List<dynamic> _value) {
    notifyListeners();

    _getInstitutionsFullData = _value;
  }

  void addToGetInstitutionsFullData(dynamic _value) {
    notifyListeners();
    _getInstitutionsFullData.add(_value);
  }

  void removeFromGetInstitutionsFullData(dynamic _value) {
    notifyListeners();
    _getInstitutionsFullData.remove(_value);
  }

  String _ConsentToken = '-';
  String get ConsentToken => _ConsentToken;
  set ConsentToken(String _value) {
    notifyListeners();

    _ConsentToken = _value;
  }

  List<DocumentReference> _usersInvolved = [
    FirebaseFirestore.instance.doc('/users/egor')
  ];
  List<DocumentReference> get usersInvolved => _usersInvolved;
  set usersInvolved(List<DocumentReference> _value) {
    notifyListeners();

    _usersInvolved = _value;
  }

  void addToUsersInvolved(DocumentReference _value) {
    notifyListeners();
    _usersInvolved.add(_value);
  }

  void removeFromUsersInvolved(DocumentReference _value) {
    notifyListeners();
    _usersInvolved.remove(_value);
  }

  List<DocumentReference> _friends = [
    FirebaseFirestore.instance.doc('/users/egor')
  ];
  List<DocumentReference> get friends => _friends;
  set friends(List<DocumentReference> _value) {
    notifyListeners();

    _friends = _value;
  }

  void addToFriends(DocumentReference _value) {
    notifyListeners();
    _friends.add(_value);
  }

  void removeFromFriends(DocumentReference _value) {
    notifyListeners();
    _friends.remove(_value);
  }

  String _SCAcode = '-';
  String get SCAcode => _SCAcode;
  set SCAcode(String _value) {
    notifyListeners();

    _SCAcode = _value;
  }

  String _EmbeddedPassword = '-';
  String get EmbeddedPassword => _EmbeddedPassword;
  set EmbeddedPassword(String _value) {
    notifyListeners();

    _EmbeddedPassword = _value;
  }

  String _EmbeddedLogin = '-';
  String get EmbeddedLogin => _EmbeddedLogin;
  set EmbeddedLogin(String _value) {
    notifyListeners();

    _EmbeddedLogin = _value;
  }

  String _SCAmethodID = '-';
  String get SCAmethodID => _SCAmethodID;
  set SCAmethodID(String _value) {
    notifyListeners();

    _SCAmethodID = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await write(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await write(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await write(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await write(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await write(key: key, value: ListToCsvConverter().convert([value]));
}
