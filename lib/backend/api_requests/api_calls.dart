import 'dart:convert';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class AuthorizationRequestCall {
  static Future<ApiCallResponse> call({
    String? institutionID = 'null',
    String? paymentIdempotencyID = '123242',
    String? amount = '',
    String? payeeName = 'null',
    String? payeeIBAN = '',
    String? payerName = 'null',
    String? payerIBAN = 'null',
    String? country = 'IT',
    String? postCodePayer = '3030CZ',
    String? postCodePayee = '3023XD',
  }) {
    final body = '''
{
  "applicationUserId": "{{application-user-id}}",
  "institutionId": "${institutionID}",
  "callback": "https://payzeal.page.link/7Yoh",
  "paymentRequest": {
    "paymentIdempotencyId": "${paymentIdempotencyID}",
    "amount": {
      "amount": "${amount}",
      "currency": "EUR"
    },
    "reference": "Payzeal",
    "type": "DOMESTIC_PAYMENT",
    "payee": {
      "name": "${payeeName}",
      "address": {
        "country": "${country}",
        "postCode": "${postCodePayee}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payeeIBAN}"
        }
      ]
    },
    "payer": {
      "name": "${payerName}",
      "address": {
        "country": "${country}",
        "postCode": "${postCodePayer}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payerIBAN}"
        }
      ]
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'authorizationRequest',
      apiUrl: 'https://api.yapily.com/payment-auth-requests',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }

  static dynamic authURL(dynamic response) => getJsonField(
        response,
        r'''$.data.authorisationUrl''',
      );
  static dynamic consentID(dynamic response) => getJsonField(
        response,
        r'''$.data.id''',
      );
}

class CreatePaymentsCall {
  static Future<ApiCallResponse> call({
    String? paymentIdenpotencyID = '',
    String? amount = '',
    String? payeeName = '',
    String? payeeIBAN = '',
    String? payerName = '',
    String? payerIBAN = '',
    String? consentToken = '',
    String? country = 'IT',
    String? postCodePayee = '2022XC',
    String? postCodePayer = '3902XH',
  }) {
    final body = '''
{
  "type": "DOMESTIC_PAYMENT",
  "reference": "Payzeal",
  "paymentIdempotencyId": "${paymentIdenpotencyID}",
  "amount": {
    "amount": "${amount}",
    "currency": "EUR"
  },
  "payee": {
    "name": "${payeeName}",
    "address": {
      "country": "${country}",
      "postCode": "${postCodePayee}"
    },
    "accountIdentifications": [
      {
        "type": "IBAN",
        "identification": "${payeeIBAN}"
      }
    ]
  },
  "payer": {
    "name": "${payerName}",
    "address": {
      "country": "${country}",
      "postCode": "${postCodePayer}"
    },
    "accountIdentifications": [
      {
        "type": "IBAN",
        "identification": "${payerIBAN}"
      }
    ]
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createPayments',
      apiUrl: 'https://api.yapily.com/payments',
      callType: ApiCallType.POST,
      headers: {
        'Consent': '${consentToken}',
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

class GetConsentCall {
  static Future<ApiCallResponse> call({
    String? consentId = 'consentId',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetConsent',
      apiUrl: 'https://api.yapily.com/consents/${consentId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      returnBody: true,
      cache: false,
    );
  }

  static dynamic consentToken(dynamic response) => getJsonField(
        response,
        r'''$.data.consentToken''',
      );
}

class GetInstitutionsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'GetInstitutions',
      apiUrl: 'https://api.yapily.com/institutions',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
        'Accept': 'application/json;charset=UTF-8',
      },
      params: {},
      returnBody: true,
      cache: false,
    );
  }

  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fullName''',
      );
  static dynamic logoReal(dynamic response) => getJsonField(
        response,
        r'''$.data[:].media[0].source''',
      );
  static dynamic authMethod(dynamic response) => getJsonField(
        response,
        r'''$.data[:1].features[5]''',
      );
  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.data[:].id''',
      );
}

class AccountAuthorizationCall {
  static Future<ApiCallResponse> call({
    String? userID = '',
    String? institution = 'modelo-sandbox',
  }) {
    final body = '''
{
  "applicationUserId": "${userID}",
  "institutionId": "${institution}",
  "callback": "https://payzeal.page.link/7Yoh"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AccountAuthorization',
      apiUrl: 'https://api.yapily.com/account-auth-requests',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }

  static dynamic authURL(dynamic response) => getJsonField(
        response,
        r'''$.data.authorisationUrl''',
      );
}

class GetAccountInformCall {
  static Future<ApiCallResponse> call({
    String? consentToken = '1',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAccountInform',
      apiUrl: 'https://api.yapily.com/accounts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
        'Consent': '${consentToken}',
      },
      params: {},
      returnBody: true,
      cache: false,
    );
  }

  static dynamic legalName(dynamic response) => getJsonField(
        response,
        r'''$.data.accountNames.name''',
      );
  static dynamic iban(dynamic response) => getJsonField(
        response,
        r'''$.data.type''',
      );
}

class PreAuthorisationCall {
  static Future<ApiCallResponse> call({
    String? applicationUserID = '',
    String? institutionID = '',
    String? scope = 'AIS',
  }) {
    final body = '''
{
  "applicationUserId": "${applicationUserID}",
  "institutionId": "${institutionID}",
  "callback": "https://payzeal.page.link/7Yoh",
  "scope": "PIS"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PreAuthorisation',
      apiUrl: 'https://api.yapily.com/pre-auth-requests',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }

  static dynamic userUuid(dynamic response) => getJsonField(
        response,
        r'''$.data.userUuid''',
      );
  static dynamic state(dynamic response) => getJsonField(
        response,
        r'''$.data.state''',
      );
  static dynamic authURL(dynamic response) => getJsonField(
        response,
        r'''$.data.authorisationUrl''',
      );
  static dynamic iDforGetConsent(dynamic response) => getJsonField(
        response,
        r'''$.data.id''',
      );
}

class PreAuthPaymentCall {
  static Future<ApiCallResponse> call({
    String? applicationUserID = '',
    String? institutionID = '',
    String? scope = '',
    String? referencePayment = '',
    String? amount = '',
    String? payeeName = '',
    String? payeeCountry = '',
    String? payeeIBAN = '',
    String? payerName = '',
    String? payerIBAN = '',
    String? payerCountry = '',
    String? paymentIdempotency = '',
    String? consentID = '',
  }) {
    final body = '''
{
  "applicationUserId": "${applicationUserID}",
  "institutionId": "${institutionID}",
  "paymentRequest": {
    "paymentIdempotencyId": "${paymentIdempotency}",
    "payer": {
      "name": "${payerName}",
      "address": {
        "country": "${payerCountry}"
        },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payerIBAN}"
        }
      ]
    },
    "amount": {
      "amount": "${amount}",
      "currency": "EUR"
    },
    "reference": "${referencePayment}",
    "type": "DOMESTIC_PAYMENT",
    "payee": {
      "name": "${payeeName}",
      "address": {
        "country": "${payeeCountry}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payeeIBAN}"
        }
      ]
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PreAuthPayment',
      apiUrl: 'https://api.yapily.com/payment-auth-requests/',
      callType: ApiCallType.PUT,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
        'Consent': '${consentID}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }

  static dynamic url(dynamic response) => getJsonField(
        response,
        r'''$.data.authorisationUrl''',
      );
}

class EmbeddedAuthFirstStepCall {
  static Future<ApiCallResponse> call({
    String? appUserID = '',
    String? institutionID = '',
    String? credID = '',
    String? credPassword = '',
    String? paymentIdempotencyID = '',
    String? paymentReference = '',
    String? amount = '',
    String? payerIBAN = '',
    String? payerCountry = '',
    String? payerName = '',
    String? payeeIBAN = '',
    String? payeeCountry = '',
    String? payerPostCode = '',
    String? payeePostCode = '',
    String? payeeName = '',
  }) {
    final body = '''
{
  "applicationUserId": "${appUserID}",
  "institutionId": "${institutionID}",
  "userCredentials": {
    "id": "${credID}",
    "password": "${credPassword}"
  },
  "paymentRequest": {
    "type": "DOMESTIC_PAYMENT",
    "paymentIdempotencyId": "${paymentIdempotencyID}",
    "payer": {
      "name": "${payerName}",
      "address": {
        "country": "${payerCountry}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payerIBAN}"
        }
      ]
    },
    "amount": {
      "amount": "${amount}",
      "currency": "EUR"
    },
    "reference": "${paymentReference}",
    "payee": {
      "name": "${payeeName}",
      "address": {
        "country": "${payeeCountry}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payeeIBAN}"
        }
      ]
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'EmbeddedAuthFirstStep',
      apiUrl: 'https://api.yapily.com/embedded-payment-auth-requests',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }

  static dynamic consentID(dynamic response) => getJsonField(
        response,
        r'''$.data.id''',
      );
}

class EmbeddedSecondStepSCACodeCall {
  static Future<ApiCallResponse> call({
    String? consentID = '',
    String? sca = '',
    String? applicationUserID = '',
    String? institutionID = '',
    String? paymentIdempotencyID = '',
    String? referencePayemtn = '',
    String? amount = '',
    String? payerName = '',
    String? payerIBAN = '',
    String? payerCountry = '',
    String? payeeName = '',
    String? payeeIBAN = '',
    String? payeeCountry = '',
  }) {
    final body = '''
{
  "applicationUserId": "${applicationUserID}",
  "institutionId": "${institutionID}",
  "scaCode": "${sca}",
  "paymentRequest": {
    "type": "DOMESTIC_PAYMENT",
    "paymentIdempotencyId": "${paymentIdempotencyID}",
    "reference": "${referencePayemtn}",
    "amount": {
      "amount": "${amount}",
      "currency": "EUR"
    },
    "payer": {
      "name": "${payerName}",
      "address": {
        "country": "${payerCountry}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payerIBAN}"
        }
      ]
    },
    "payee": {
      "name": "${payeeName}",
      "address": {
        "country": "${payeeCountry}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payeeIBAN}"
        }
      ]
    }
  }
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'EmbeddedSecondStep SCA Code',
      apiUrl:
          'https://api.yapily.com/embedded-payment-auth-requests/${consentID}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

class EmbeddedThirdStepCall {
  static Future<ApiCallResponse> call({
    String? consentID = '',
    String? appUserID = '',
    String? institutionID = '',
    String? selectedSCAMethodID = '',
    String? paymentIdempotencyId = '',
    String? referencePayment = '',
    String? amount = '',
    String? payerName = '',
    String? payerIBAN = '',
    String? payerCountry = '',
    String? payerPostCode = '',
    String? payeeName = '',
    String? payeeIBAN = '',
    String? payeePostCode = '',
    String? payeeCountry = '',
  }) {
    final body = '''
{
  "applicationUserId": "${appUserID}",
  "institutionId": "${institutionID}",
  "selectedScaMethod": {
    "id": "${selectedSCAMethodID}"
  },
  "paymentRequest": {
    "type": "DOMESTIC_PAYMENT",
    "paymentIdempotencyId": "${paymentIdempotencyId}",
    "payer": {
      "name": "${payerName}",
      "address": {
      "country": "${payerCountry}"
        },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification":"${payerIBAN}"
        }
      ]
    },
    "amount": {
      "amount": "${amount}",
      "currency": "EUR"
    },
    "reference": "${referencePayment}",
    "payee": {
      "name": "${payeeName}",
      "address": {
        "country": "${payeeCountry}"
      },
      "accountIdentifications": [
        {
          "type": "IBAN",
          "identification": "${payeeIBAN}"
        }
      ]
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'EmbeddedThirdStep',
      apiUrl:
          'https://api.yapily.com/embedded-payment-auth-requests/${consentID}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization':
            'Basic MzVkNWQxYTItNWEwZi00YzgyLTg4NGYtZjU4NTYzZDZiNWJkOlZWMmVBekFCWHd6aWhmaTVnMzFzdkxDMFFvN1V2dGFv',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
