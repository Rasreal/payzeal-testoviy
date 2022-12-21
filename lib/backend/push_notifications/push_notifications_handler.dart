import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Image.asset(
            'assets/images/Group_285.png',
            fit: BoxFit.cover,
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'forgotPassword': (data) async => ForgotPasswordWidget(),
  'registerAccount': (data) async => RegisterAccountWidget(),
  'changePassword': (data) async => ChangePasswordWidget(),
  'completeProfile': (data) async => CompleteProfileWidget(),
  'editProfile': (data) async => EditProfileWidget(
        userProfile: getParameter(data, 'userProfile'),
      ),
  'Recepients_money_transfer': (data) async => RecepientsMoneyTransferWidget(),
  'transferComplete': (data) async => TransferCompleteWidget(
        balancereciever: getParameter(data, 'balancereciever'),
        referenceReciever: getParameter(data, 'referenceReciever'),
        transactionAM: getParameter(data, 'transactionAM'),
      ),
  'transferFunds': (data) async => TransferFundsWidget(
        nameReciever: getParameter(data, 'nameReciever'),
        referencereciever: getParameter(data, 'referencereciever'),
        recipientImage: getParameter(data, 'recipientImage'),
        amount: getParameter(data, 'amount'),
        transactionComment: getParameter(data, 'transactionComment'),
      ),
  'PaymentConfirm': (data) async => PaymentConfirmWidget(
        consentID: getParameter(data, 'consentID'),
        payerName: getParameter(data, 'payerName'),
        payerIBAN: getParameter(data, 'payerIBAN'),
        paymentReference: getParameter(data, 'paymentReference'),
        payeeName: getParameter(data, 'payeeName'),
        payeeIBAN: getParameter(data, 'payeeIBAN'),
        paymentIdempotency: getParameter(data, 'paymentIdempotency'),
        amount: getParameter(data, 'amount'),
        photo: getParameter(data, 'photo'),
        recipientReference: getParameter(data, 'recipientReference'),
        isPublic: getParameter(data, 'isPublic'),
        amountINT: getParameter(data, 'amountINT'),
        transactionPicture: getParameter(data, 'transactionPicture'),
        payeePostCode: getParameter(data, 'payeePostCode'),
      ),
  'Onboarding': (data) async => OnboardingWidget(),
  'pndingRequests': (data) async => PndingRequestsWidget(),
  'transferFundsCopy': (data) async => TransferFundsCopyWidget(
        nameReciever: getParameter(data, 'nameReciever'),
        referencereciever: getParameter(data, 'referencereciever'),
        recipientImage: getParameter(data, 'recipientImage'),
      ),
  'success_request': (data) async => SuccessRequestWidget(),
  'Recepients_money_transferCopy': (data) async =>
      RecepientsMoneyTransferCopyWidget(
        nameReciever: getParameter(data, 'nameReciever'),
        referenceReciever: getParameter(data, 'referenceReciever'),
        photoReciever: getParameter(data, 'photoReciever'),
      ),
  'loginPage': (data) async => LoginPageWidget(),
  'MY_profilePage': (data) async => MYProfilePageWidget(
        userProfile: getParameter(data, 'userProfile'),
      ),
  'FriendsAdd': (data) async => FriendsAddWidget(),
  'PaymentConfirmPreAuthFlow': (data) async => PaymentConfirmPreAuthFlowWidget(
        consentID: getParameter(data, 'consentID'),
        payerName: getParameter(data, 'payerName'),
        payerIBAN: getParameter(data, 'payerIBAN'),
        paymentReference: getParameter(data, 'paymentReference'),
        payeeName: getParameter(data, 'payeeName'),
        payeeIBAN: getParameter(data, 'payeeIBAN'),
        paymentIdempotency: getParameter(data, 'paymentIdempotency'),
        amount: getParameter(data, 'amount'),
        photo: getParameter(data, 'photo'),
        recipientReference: getParameter(data, 'recipientReference'),
        isPublic: getParameter(data, 'isPublic'),
        amountINT: getParameter(data, 'amountINT'),
        transactionPicture: getParameter(data, 'transactionPicture'),
        payeePostCode: getParameter(data, 'payeePostCode'),
        payeeCountry: getParameter(data, 'payeeCountry'),
        consentToken1: getParameter(data, 'consentToken1'),
      ),
  'LoginForEmbedded': (data) async => LoginForEmbeddedWidget(
        payeeName: getParameter(data, 'payeeName'),
        payeeIBAN: getParameter(data, 'payeeIBAN'),
        payeeCountry: getParameter(data, 'payeeCountry'),
        paymentRef: getParameter(data, 'paymentRef'),
        amount: getParameter(data, 'amount'),
        payeePostCode: getParameter(data, 'payeePostCode'),
      ),
  'UserName': (data) async => UserNameWidget(),
  'LegalName': (data) async => LegalNameWidget(),
  'PostCodeCountry': (data) async => PostCodeCountryWidget(),
  'University': (data) async => UniversityWidget(),
  'BankName': (data) async => BankNameWidget(),
  'listInstitutionsCopy': (data) async => ListInstitutionsCopyWidget(
        institutionsids: getParameter(data, 'institutionsids'),
      ),
  'FriendsAddOnboarding': (data) async => FriendsAddOnboardingWidget(),
  'EmbeddedPinSCA': (data) async => EmbeddedPinSCAWidget(
        payeeName: getParameter(data, 'payeeName'),
        payeeCountry: getParameter(data, 'payeeCountry'),
        payeePostCode: getParameter(data, 'payeePostCode'),
        paymentRef: getParameter(data, 'paymentRef'),
        amount: getParameter(data, 'amount'),
        consentID: getParameter(data, 'consentID'),
        payeeIBAN: getParameter(data, 'payeeIBAN'),
        idempotencyID: getParameter(data, 'idempotencyID'),
      ),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
