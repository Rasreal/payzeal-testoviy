import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

bool referenceisinlist(
  List<DocumentReference> contactsref,
  DocumentReference sender,
) {
  if (contactsref != null) {
    for (int i = 0; i < contactsref.length; i++) {
      if (sender == contactsref[i]) {
        return true;
      }
    }
    return false;
  }
  return false;
}

String strtorefname(DocumentReference nameref) {
  return nameref.toString();
}

List<DocumentReference> usersInvolved(
  DocumentReference user1,
  DocumentReference user2,
) {
  List<DocumentReference> usersInvolved = [user1, user2];
  return usersInvolved;
}

bool transactionVisibleForFriends(
  List<DocumentReference> listContacts,
  List<DocumentReference> usersInvolved,
) {
  if (listContacts != null) {
    for (var i = 0; i < listContacts.length; i++) {
      for (var g = 0; g < usersInvolved.length; g++) {
        if (usersInvolved[g] == listContacts?[i]) {
          return true;
        }
      }
    }
    return false;
  }
  return false;
}

String identiponency() {
  int length = 35;
  final _random = math.Random();
  const _availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final randomString = List.generate(length,
          (index) => _availableChars[_random.nextInt(_availableChars.length)])
      .join();

  return randomString;
}

bool amount10k(String amount) {
  if (amount != null) {
    int len = amount.length;
    if (len > 4) {
      return false;
    }
    return true;
  }
  return false;
}

String? getAuthType(List<String> features) {
  // Add your function code here!

  if (features.contains("INITIATE_EMBEDDED_DOMESTIC_SINGLE_PAYMENT")) {
    return "embeded";
  } else if (features.contains("INITIATE_DOMESTIC_SINGLE_PAYMENT") &&
      !features.contains("INITIATE_PRE_AUTHORISATION") &&
      !features.contains("INITIATE_EMBEDDED_DOMESTIC_SINGLE_PAYMENT")) {
    return "redirect";
  } else if (features.contains("INITIATE_DOMESTIC_SINGLE_PAYMENT") &&
      features.contains("INITIATE_PRE_AUTHORISATION")) {
    return "pre authorization";
  }
}
