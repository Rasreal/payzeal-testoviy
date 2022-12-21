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

class PaymentConfirmWidget extends StatefulWidget {
  const PaymentConfirmWidget({
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

  @override
  _PaymentConfirmWidgetState createState() => _PaymentConfirmWidgetState();
}

class _PaymentConfirmWidgetState extends State<PaymentConfirmWidget> {
  ApiCallResponse? apiCall6;
  ApiCallResponse? getConsentInAction;
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

    return FutureBuilder<ApiCallResponse>(
      future: GetConsentCall.call(
        consentId: widget.consentID,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: SpinKitSquareCircle(
                color: FlutterFlowTheme.of(context).tertiaryColor,
                size: 40,
              ),
            ),
          );
        }
        final paymentConfirmGetConsentResponse = snapshot.data!;
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
                            currentUserLocationValue =
                                await getCurrentUserLocation(
                                    defaultLocation: LatLng(0.0, 0.0));
                            getConsentInAction = await GetConsentCall.call(
                              consentId: widget.consentID,
                            );
                            if (!paymentConfirmGetConsentResponse.succeeded) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('ooops consent error!'),
                                    content: Text(
                                        'Write on egor@payzeal.co if you got it!'),
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

                              context.pushNamed('Feed');
                            }
                            apiCall6 = await CreatePaymentsCall.call(
                              consentToken: getJsonField(
                                (getConsentInAction?.jsonBody ?? ''),
                                r'''$.data.consentToken''',
                              ).toString(),
                              paymentIdenpotencyID: widget.paymentIdempotency,
                              amount: widget.amount,
                              payeeName: widget.payeeName,
                              payeeIBAN: widget.payeeIBAN,
                              payerName: widget.payerName,
                              payerIBAN: widget.payerIBAN,
                              country: valueOrDefault(
                                  currentUserDocument?.countryCode, ''),
                              postCodePayer: valueOrDefault(
                                  currentUserDocument?.postCode, ''),
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

                              context.pushNamed('Feed');
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
      },
    );
  }
}
