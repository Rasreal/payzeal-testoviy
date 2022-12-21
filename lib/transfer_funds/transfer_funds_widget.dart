import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransferFundsWidget extends StatefulWidget {
  const TransferFundsWidget({
    Key? key,
    this.nameReciever,
    this.referencereciever,
    this.recipientImage,
    this.amount,
    this.transactionComment,
  }) : super(key: key);

  final String? nameReciever;
  final DocumentReference? referencereciever;
  final String? recipientImage;
  final String? amount;
  final String? transactionComment;

  @override
  _TransferFundsWidgetState createState() => _TransferFundsWidgetState();
}

class _TransferFundsWidgetState extends State<TransferFundsWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textFieldOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 170.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 170.ms,
          duration: 600.ms,
          begin: Offset(0, 80),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 170.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: -220.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: -220.ms,
          duration: 600.ms,
          begin: 0.4,
          end: 1,
        ),
      ],
    ),
  };
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  TextEditingController? textController1;
  TextEditingController? textController2;
  bool? checkboxListTileValue;
  ApiCallResponse? apiResult73f;
  ApiCallResponse? authRequestReturn;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    textController1 = TextEditingController(
        text: valueOrDefault<String>(
      widget.amount,
      '10',
    ));
    textController2 = TextEditingController(text: widget.transactionComment);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.referencereciever!),
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
        final transferFundsUsersRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).background,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 44, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Transfer cash',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Open Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterFlowTheme.of(context).background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              buttonSize: 48,
                              icon: Icon(
                                Icons.close_rounded,
                                color: FlutterFlowTheme.of(context).errorRed,
                                size: 30,
                              ),
                              onPressed: () async {
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                        child: TextFormField(
                          controller: textController1,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '\$ Amount',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).grayLight,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).grayLight,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 24, 24),
                          ),
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.normal,
                              ),
                          keyboardType: TextInputType.number,
                        ).animateOnPageLoad(
                            animationsMap['textFieldOnPageLoadAnimation']!),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              valueOrDefault<String>(
                                widget.recipientImage,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: AutoSizeText(
                              valueOrDefault<String>(
                                widget.nameReciever,
                                'null',
                              ),
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: TextFormField(
                                  controller: textController2,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Transaction comment',
                                    hintText: 'Please enter comment...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .grayLight,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .grayLight,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            24, 24, 24, 24),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final selectedMedia = await selectMedia(
                              imageQuality: 10,
                              multiImage: false,
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              setState(() => isMediaUploading = true);
                              var downloadUrls = <String>[];
                              try {
                                showUploadMessage(
                                  context,
                                  'Uploading file...',
                                  showLoading: true,
                                );
                                downloadUrls = (await Future.wait(
                                  selectedMedia.map(
                                    (m) async => await uploadData(
                                        m.storagePath, m.bytes),
                                  ),
                                ))
                                    .where((u) => u != null)
                                    .map((u) => u!)
                                    .toList();
                              } finally {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                isMediaUploading = false;
                              }
                              if (downloadUrls.length == selectedMedia.length) {
                                setState(
                                    () => uploadedFileUrl = downloadUrls.first);
                                showUploadMessage(context, 'Success!');
                              } else {
                                setState(() {});
                                showUploadMessage(
                                    context, 'Failed to upload media');
                                return;
                              }
                            }
                          },
                          text: 'Add a picture!',
                          icon: Icon(
                            Icons.photo_camera,
                            color: FlutterFlowTheme.of(context).background,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            textStyle: FlutterFlowTheme.of(context)
                                .title1
                                .override(
                                  fontFamily: 'Open Sans',
                                  color:
                                      FlutterFlowTheme.of(context).background,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xFF707070),
                        ),
                        child: CheckboxListTile(
                          value: checkboxListTileValue ??= true,
                          onChanged: (newValue) async {
                            setState(() => checkboxListTileValue = newValue!);
                          },
                          title: Text(
                            'Make my transaction public',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).subtitle2,
                          ),
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(1),
                              bottomRight: Radius.circular(1),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(1),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: AutoSizeText(
                          'To easily make payments from your bank, we are about to securely re-direct you to your bank where you will be asked to confirm the payment via Yapily Connect, a National Bank of Lithuania regulated payment initiation provider for Payzeal. \n\nYapily Connect will share these details with your bank, where you will be asked to confirm this payment.',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Open Sans',
                                color: FlutterFlowTheme.of(context).grayLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AutoSizeText(
                              'Initiating payment I agree with ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            InkWell(
                              onTap: () async {
                                await launchURL(
                                    'https://www.yapily.com/legal/yapilyconnect-terms-and-conditions/');
                              },
                              child: AutoSizeText(
                                'Yapily Connect\'s T&C',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF75CCEB),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0.5),
                            child: FFButtonWidget(
                              onPressed: () async {
                                var _shouldSetState = false;
                                setState(() {
                                  FFAppState().indempotencyID =
                                      valueOrDefault<String>(
                                    functions.identiponency(),
                                    'unique1',
                                  );
                                });
                                if (functions
                                    .amount10k(textController1!.text)) {
                                  if (valueOrDefault(
                                          currentUserDocument?.typeAuth, '') ==
                                      'pre authorization') {
                                    apiResult73f =
                                        await PreAuthorisationCall.call(
                                      applicationUserID: currentUserUid,
                                      institutionID: valueOrDefault(
                                          currentUserDocument
                                              ?.choosenInstitution,
                                          ''),
                                    );
                                    _shouldSetState = true;
                                    if ((apiResult73f?.succeeded ?? true)) {
                                      await actions.launchBrowser(
                                        PreAuthorisationCall.authURL(
                                          (apiResult73f?.jsonBody ?? ''),
                                        ).toString(),
                                      );

                                      context.pushNamed(
                                        'PaymentConfirmPreAuthFlow',
                                        queryParams: {
                                          'consentID': serializeParam(
                                            PreAuthorisationCall
                                                .iDforGetConsent(
                                              (apiResult73f?.jsonBody ?? ''),
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                          'payerName': serializeParam(
                                            currentUserDisplayName,
                                            ParamType.String,
                                          ),
                                          'payerIBAN': serializeParam(
                                            valueOrDefault(
                                                currentUserDocument?.iban, ''),
                                            ParamType.String,
                                          ),
                                          'paymentReference': serializeParam(
                                            textController2!.text,
                                            ParamType.String,
                                          ),
                                          'payeeName': serializeParam(
                                            transferFundsUsersRecord
                                                .displayName,
                                            ParamType.String,
                                          ),
                                          'payeeIBAN': serializeParam(
                                            transferFundsUsersRecord.iban,
                                            ParamType.String,
                                          ),
                                          'paymentIdempotency': serializeParam(
                                            FFAppState().indempotencyID,
                                            ParamType.String,
                                          ),
                                          'amount': serializeParam(
                                            textController1!.text,
                                            ParamType.String,
                                          ),
                                          'photo': serializeParam(
                                            uploadedFileUrl,
                                            ParamType.String,
                                          ),
                                          'recipientReference': serializeParam(
                                            transferFundsUsersRecord.reference,
                                            ParamType.DocumentReference,
                                          ),
                                          'isPublic': serializeParam(
                                            checkboxListTileValue,
                                            ParamType.bool,
                                          ),
                                          'amountINT': serializeParam(
                                            int.tryParse(textController1!.text),
                                            ParamType.int,
                                          ),
                                          'transactionPicture': serializeParam(
                                            uploadedFileUrl,
                                            ParamType.String,
                                          ),
                                          'payeePostCode': serializeParam(
                                            transferFundsUsersRecord.postCode,
                                            ParamType.String,
                                          ),
                                          'payeeCountry': serializeParam(
                                            transferFundsUsersRecord
                                                .countryCode,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );

                                      if (_shouldSetState) setState(() {});
                                      return;
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text(
                                                'This auth flow went wrong! Check your data or email us on egor@payzeal.co'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      context.pushNamed('Feed');
                                    }
                                  } else {
                                    if (valueOrDefault(
                                            currentUserDocument?.typeAuth,
                                            '') ==
                                        'embeded') {
                                      context.pushNamed(
                                        'LoginForEmbedded',
                                        queryParams: {
                                          'payeeName': serializeParam(
                                            transferFundsUsersRecord
                                                .displayName,
                                            ParamType.String,
                                          ),
                                          'payeeIBAN': serializeParam(
                                            transferFundsUsersRecord.iban,
                                            ParamType.String,
                                          ),
                                          'payeeCountry': serializeParam(
                                            transferFundsUsersRecord
                                                .countryCode,
                                            ParamType.String,
                                          ),
                                          'paymentRef': serializeParam(
                                            textController2!.text,
                                            ParamType.String,
                                          ),
                                          'amount': serializeParam(
                                            textController1!.text,
                                            ParamType.String,
                                          ),
                                          'payeePostCode': serializeParam(
                                            transferFundsUsersRecord.postCode,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    }
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Too fat to transfer :('),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  context.pushNamed('Feed');
                                }

                                // AuthRequest
                                authRequestReturn =
                                    await AuthorizationRequestCall.call(
                                  institutionID: valueOrDefault<String>(
                                    valueOrDefault(
                                        currentUserDocument?.choosenInstitution,
                                        ''),
                                    'null',
                                  ),
                                  amount: valueOrDefault<String>(
                                    textController1!.text,
                                    '1',
                                  ),
                                  paymentIdempotencyID: valueOrDefault<String>(
                                    FFAppState().indempotencyID,
                                    'null',
                                  ),
                                  payeeName:
                                      transferFundsUsersRecord.displayName,
                                  payeeIBAN: transferFundsUsersRecord.iban,
                                  payerName: currentUserDisplayName,
                                  payerIBAN: valueOrDefault(
                                      currentUserDocument?.iban, ''),
                                  country: transferFundsUsersRecord.countryCode,
                                  postCodePayer: valueOrDefault(
                                      currentUserDocument?.postCode, ''),
                                  postCodePayee:
                                      transferFundsUsersRecord.postCode,
                                );
                                _shouldSetState = true;
                                if ((authRequestReturn?.succeeded ?? true)) {
                                  await actions.launchBrowser(
                                    AuthorizationRequestCall.authURL(
                                      (authRequestReturn?.jsonBody ?? ''),
                                    ).toString(),
                                  );
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Something went wrong...'),
                                        content: Text(
                                            'We are already working on it. Meanwhile, please check if all the data in the profile is correct'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  context.pushNamed('Feed');
                                }

                                // Navigate

                                context.pushNamed(
                                  'PaymentConfirm',
                                  queryParams: {
                                    'consentID': serializeParam(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          (authRequestReturn?.jsonBody ?? ''),
                                          r'''$.data.id''',
                                        ).toString(),
                                        'null',
                                      ),
                                      ParamType.String,
                                    ),
                                    'payerName': serializeParam(
                                      currentUserDisplayName,
                                      ParamType.String,
                                    ),
                                    'payerIBAN': serializeParam(
                                      valueOrDefault(
                                          currentUserDocument?.iban, ''),
                                      ParamType.String,
                                    ),
                                    'paymentReference': serializeParam(
                                      textController2!.text,
                                      ParamType.String,
                                    ),
                                    'amount': serializeParam(
                                      textController1!.text,
                                      ParamType.String,
                                    ),
                                    'payeeName': serializeParam(
                                      transferFundsUsersRecord.displayName,
                                      ParamType.String,
                                    ),
                                    'payeeIBAN': serializeParam(
                                      transferFundsUsersRecord.iban,
                                      ParamType.String,
                                    ),
                                    'paymentIdempotency': serializeParam(
                                      FFAppState().indempotencyID,
                                      ParamType.String,
                                    ),
                                    'recipientReference': serializeParam(
                                      widget.referencereciever,
                                      ParamType.DocumentReference,
                                    ),
                                    'isPublic': serializeParam(
                                      checkboxListTileValue,
                                      ParamType.bool,
                                    ),
                                    'amountINT': serializeParam(
                                      int.tryParse(textController1!.text),
                                      ParamType.int,
                                    ),
                                    'transactionPicture': serializeParam(
                                      uploadedFileUrl,
                                      ParamType.String,
                                    ),
                                    'payeePostCode': serializeParam(
                                      transferFundsUsersRecord.postCode,
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );

                                if (_shouldSetState) setState(() {});
                              },
                              text: 'Pay',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .background,
                                    ),
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ).animateOnPageLoad(
                          animationsMap['rowOnPageLoadAnimation']!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
