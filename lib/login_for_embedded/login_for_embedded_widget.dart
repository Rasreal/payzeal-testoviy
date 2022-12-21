import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginForEmbeddedWidget extends StatefulWidget {
  const LoginForEmbeddedWidget({
    Key? key,
    this.payeeName,
    this.payeeIBAN,
    this.payeeCountry,
    this.paymentRef,
    this.amount,
    this.payeePostCode,
  }) : super(key: key);

  final String? payeeName;
  final String? payeeIBAN;
  final String? payeeCountry;
  final String? paymentRef;
  final String? amount;
  final String? payeePostCode;

  @override
  _LoginForEmbeddedWidgetState createState() => _LoginForEmbeddedWidgetState();
}

class _LoginForEmbeddedWidgetState extends State<LoginForEmbeddedWidget> {
  ApiCallResponse? apiResulte8e;
  TextEditingController? emailAddressController;
  TextEditingController? passwordLoginController;

  late bool passwordLoginVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordLoginController = TextEditingController();
    passwordLoginVisibility = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    emailAddressController?.dispose();
    passwordLoginController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
            child: AutoSizeText(
              'Enter your bank login details',
              style: FlutterFlowTheme.of(context).title3,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: Text(
              'Your bank requires you to enter your login details to confirm your payment. We do not store this data and pass it directly to your bank for confirmaiton.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintText: 'Enter your login...',
                  hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).gray200,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: passwordLoginController,
                obscureText: !passwordLoginVisibility,
                decoration: InputDecoration(
                  labelStyle: FlutterFlowTheme.of(context).bodyText2,
                  hintText: 'Please enter your password...',
                  hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).gray200,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                      () => passwordLoginVisibility = !passwordLoginVisibility,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      passwordLoginVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 22,
                    ),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                setState(() {
                  FFAppState().EmbeddedLogin = emailAddressController!.text;
                  FFAppState().EmbeddedPassword = passwordLoginController!.text;
                });
                setState(() {
                  FFAppState().indempotencyID = functions.identiponency();
                });
                apiResulte8e = await EmbeddedAuthFirstStepCall.call(
                  appUserID: currentUserUid,
                  institutionID: valueOrDefault(
                      currentUserDocument?.choosenInstitution, ''),
                  credID: passwordLoginController!.text,
                  credPassword: passwordLoginController!.text,
                  paymentIdempotencyID: FFAppState().indempotencyID,
                  paymentReference: widget.paymentRef,
                  amount: widget.amount,
                  payerIBAN: valueOrDefault(currentUserDocument?.iban, ''),
                  payerCountry:
                      valueOrDefault(currentUserDocument?.countryCode, ''),
                  payerName: currentUserDisplayName,
                  payeeIBAN: widget.payeeIBAN,
                  payeeCountry: widget.payeeCountry,
                  payerPostCode:
                      valueOrDefault(currentUserDocument?.postCode, ''),
                  payeeName: widget.payeeName,
                  payeePostCode: widget.payeePostCode,
                );
                if ((apiResulte8e?.succeeded ?? true)) {
                  context.goNamed(
                    'EmbeddedPinSCA',
                    queryParams: {
                      'payeeName': serializeParam(
                        widget.payeeName,
                        ParamType.String,
                      ),
                      'payeeCountry': serializeParam(
                        widget.payeeCountry,
                        ParamType.String,
                      ),
                      'payeePostCode': serializeParam(
                        widget.payeePostCode,
                        ParamType.String,
                      ),
                      'paymentRef': serializeParam(
                        widget.paymentRef,
                        ParamType.String,
                      ),
                      'amount': serializeParam(
                        widget.amount,
                        ParamType.String,
                      ),
                      'consentID': serializeParam(
                        EmbeddedAuthFirstStepCall.consentID(
                          (apiResulte8e?.jsonBody ?? ''),
                        ).toString(),
                        ParamType.String,
                      ),
                      'payeeIBAN': serializeParam(
                        widget.payeeIBAN,
                        ParamType.String,
                      ),
                      'idempotencyID': serializeParam(
                        FFAppState().indempotencyID,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                  );
                }

                setState(() {});
              },
              text: 'Authorise',
              options: FFButtonOptions(
                width: 270,
                height: 50,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      fontSize: 16,
                    ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
