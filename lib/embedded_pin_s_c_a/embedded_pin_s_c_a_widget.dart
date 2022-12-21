import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmbeddedPinSCAWidget extends StatefulWidget {
  const EmbeddedPinSCAWidget({
    Key? key,
    this.payeeName,
    this.payeeCountry,
    this.payeePostCode,
    this.paymentRef,
    this.amount,
    this.consentID,
    this.payeeIBAN,
    this.idempotencyID,
  }) : super(key: key);

  final String? payeeName;
  final String? payeeCountry;
  final String? payeePostCode;
  final String? paymentRef;
  final String? amount;
  final String? consentID;
  final String? payeeIBAN;
  final String? idempotencyID;

  @override
  _EmbeddedPinSCAWidgetState createState() => _EmbeddedPinSCAWidgetState();
}

class _EmbeddedPinSCAWidgetState extends State<EmbeddedPinSCAWidget> {
  ApiCallResponse? apiResult6ys;
  ApiCallResponse? apiResultzj1;
  ApiCallResponse? apiResultxin;
  TextEditingController? pinCodeController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: AutoSizeText(
          'Enter Pin Code Below',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Confirm your Code',
                    style: FlutterFlowTheme.of(context).title3,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                    child: AutoSizeText(
                      'This code helps keep your account safe and secure.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      textStyle: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: 'Open Sans',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      enableActiveFill: true,
                      autoFocus: true,
                      showCursor: true,
                      cursorColor: FlutterFlowTheme.of(context).primaryColor,
                      obscureText: false,
                      hintCharacter: '-',
                      pinTheme: PinTheme(
                        fieldHeight: 60,
                        fieldWidth: 60,
                        borderWidth: 2,
                        borderRadius: BorderRadius.circular(12),
                        shape: PinCodeFieldShape.box,
                        activeColor: FlutterFlowTheme.of(context).primaryColor,
                        inactiveColor: FlutterFlowTheme.of(context).lineColor,
                        selectedColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        activeFillColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        inactiveFillColor:
                            FlutterFlowTheme.of(context).lineColor,
                        selectedFillColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                      controller: pinCodeController,
                      onChanged: (_) => {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
              child: FFButtonWidget(
                onPressed: () async {
                  apiResultzj1 = await EmbeddedSecondStepSCACodeCall.call(
                    consentID: widget.consentID,
                    sca: pinCodeController!.text,
                    applicationUserID: currentUserUid,
                    institutionID: valueOrDefault(
                        currentUserDocument?.choosenInstitution, ''),
                    paymentIdempotencyID: widget.idempotencyID,
                    referencePayemtn: widget.paymentRef,
                    amount: widget.amount,
                    payerName: currentUserDisplayName,
                    payerIBAN: valueOrDefault(currentUserDocument?.iban, ''),
                    payerCountry:
                        valueOrDefault(currentUserDocument?.countryCode, ''),
                    payeeName: widget.payeeName,
                    payeeIBAN: widget.payeeIBAN,
                    payeeCountry: widget.payeeCountry,
                  );
                  if ((apiResultzj1?.succeeded ?? true)) {
                    apiResult6ys = await GetConsentCall.call(
                      consentId: widget.consentID,
                    );
                    if ((apiResult6ys?.succeeded ?? true)) {
                      apiResultxin = await CreatePaymentsCall.call(
                        paymentIdenpotencyID: widget.idempotencyID,
                        amount: widget.amount,
                        payeeName: widget.payeeName,
                        payeeIBAN: widget.payeeIBAN,
                        payerName: currentUserDisplayName,
                        payerIBAN:
                            valueOrDefault(currentUserDocument?.iban, ''),
                        consentToken: GetConsentCall.consentToken(
                          (apiResult6ys?.jsonBody ?? ''),
                        ).toString(),
                        country: valueOrDefault(
                            currentUserDocument?.countryCode, ''),
                        postCodePayee: widget.payeePostCode,
                        postCodePayer:
                            valueOrDefault(currentUserDocument?.postCode, ''),
                      );
                      if ((apiResultxin?.succeeded ?? true)) {
                        context.pushNamed('transferComplete');
                      }
                    }
                  }

                  setState(() {});
                },
                text: 'Confirm & Continue',
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                  elevation: 2,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
