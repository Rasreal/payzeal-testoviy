import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../backend/push_notifications/push_notifications_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentConfirmPreAuthFlowWidget extends StatefulWidget {
  const PaymentConfirmPreAuthFlowWidget({
    Key? key,
    this.consentID,
    this.payerName,
    this.payerIBAN,
    this.paymentReference,
    this.payeeName,
    this.payeeIBAN,
    this.paymentIdempotency,
    this.amount,
    this.photo,
    this.recipientReference,
    this.isPublic,
    this.amountINT,
    this.transactionPicture,
    this.payeePostCode,
    this.payeeCountry,
    this.consentToken1,
  }) : super(key: key);

  final String? consentID;
  final String? payerName;
  final String? payerIBAN;
  final String? paymentReference;
  final String? payeeName;
  final String? payeeIBAN;
  final String? paymentIdempotency;
  final String? amount;
  final String? photo;
  final DocumentReference? recipientReference;
  final bool? isPublic;
  final int? amountINT;
  final String? transactionPicture;
  final String? payeePostCode;
  final String? payeeCountry;
  final String? consentToken1;

  @override
  _PaymentConfirmPreAuthFlowWidgetState createState() =>
      _PaymentConfirmPreAuthFlowWidgetState();
}

class _PaymentConfirmPreAuthFlowWidgetState
    extends State<PaymentConfirmPreAuthFlowWidget> {
  ApiCallResponse? apiCall1;
  ApiCallResponse? getConsentVar;
  ApiCallResponse? apiCall6;
  LatLng? currentUserLocationValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        setState(
            () => FFAppState().addToUsersInvolved(widget.recipientReference!));
        setState(() => FFAppState().addToUsersInvolved(currentUserReference!));
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                child: AutoSizeText(
                  'Confirm your payment!',
                  style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF111111),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 220, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        context.pop();
                      },
                      text: 'Cancel',
                      options: FFButtonOptions(
                        width: 100,
                        height: 50,
                        color: Color(0xFF262D34),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        currentUserLocationValue = await getCurrentUserLocation(
                            defaultLocation: LatLng(0.0, 0.0));
                        getConsentVar = await GetConsentCall.call(
                          consentId: widget.consentID,
                        );
                        apiCall1 = await PreAuthPaymentCall.call(
                          paymentIdempotency: widget.paymentIdempotency,
                          applicationUserID: currentUserUid,
                          institutionID: valueOrDefault(
                              currentUserDocument?.choosenInstitution, ''),
                          scope: 'PIS',
                          referencePayment: widget.paymentReference,
                          amount: widget.amount,
                          payeeName: widget.payeeName,
                          payeeCountry: widget.payeeCountry,
                          payeeIBAN: widget.payeeIBAN,
                          payerName: currentUserDisplayName,
                          payerIBAN:
                              valueOrDefault(currentUserDocument?.iban, ''),
                          payerCountry: valueOrDefault(
                              currentUserDocument?.countryCode, ''),
                          consentID: GetConsentCall.consentToken(
                            (getConsentVar?.jsonBody ?? ''),
                          ).toString(),
                        );
                        await launchURL(PreAuthPaymentCall.url(
                          (apiCall1?.jsonBody ?? ''),
                        ).toString());
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Did you confirm in the app?'),
                              content: Text(
                                  'Please confirm in your banking application before proceeding'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                        apiCall6 = await CreatePaymentsCall.call(
                          consentToken: GetConsentCall.consentToken(
                            (getConsentVar?.jsonBody ?? ''),
                          ).toString(),
                          paymentIdenpotencyID: widget.paymentIdempotency,
                          amount: widget.amount,
                          payeeName: widget.payeeName,
                          payeeIBAN: widget.payeeIBAN,
                          payerName: currentUserDisplayName,
                          payerIBAN:
                              valueOrDefault(currentUserDocument?.iban, ''),
                          country: valueOrDefault(
                              currentUserDocument?.countryCode, ''),
                          postCodePayer:
                              valueOrDefault(currentUserDocument?.postCode, ''),
                          postCodePayee: widget.payeePostCode,
                        );
                        if ((apiCall6?.succeeded ?? true)) {
                          // CreateRecord

                          final transactionsCreateData = {
                            ...createTransactionsRecordData(
                              transactionTime: getCurrentTimestamp,
                              comment: widget.paymentReference,
                              transactionAmount: widget.amountINT,
                              sender: currentUserReference,
                              recipientReference: widget.recipientReference,
                              isPublic: widget.isPublic,
                              transactionLocation: currentUserLocationValue,
                              createdTime: getCurrentTimestamp,
                              transactionPicture: widget.transactionPicture,
                            ),
                            'usersInvolved': FFAppState().usersInvolved,
                          };
                          await TransactionsRecord.collection
                              .doc()
                              .set(transactionsCreateData);
                          triggerPushNotification(
                            notificationTitle: 'You just got some cash!',
                            notificationText: widget.paymentReference!,
                            notificationImageUrl: widget.transactionPicture,
                            notificationSound: 'default',
                            userRefs: [widget.recipientReference!],
                            initialPageName: 'Feed',
                            parameterData: {},
                          );

                          context.pushNamed('Feed');
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Something went wrong!'),
                                content: Text('Try to  authorize again'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        setState(() {});
                      },
                      text: 'Confirm!',
                      options: FFButtonOptions(
                        width: 150,
                        height: 50,
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
