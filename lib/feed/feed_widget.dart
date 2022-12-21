import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/test_trans_card_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<UserFriendsRecord>>(
      future: queryUserFriendsRecordOnce(
        parent: currentUserReference,
        queryBuilder: (userFriendsRecord) => userFriendsRecord
            .where('UserReference', isEqualTo: currentUserReference),
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
        List<UserFriendsRecord> feedUserFriendsRecordList = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 60, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  'Vibes',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 20, 0),
                                          child: InkWell(
                                            onTap: () async {
                                              context
                                                  .pushNamed('MY_profilePage');
                                            },
                                            child: Icon(
                                              Icons.settings_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 20, 0),
                                          child: InkWell(
                                            onTap: () async {
                                              context
                                                  .pushNamed('pndingRequests');
                                            },
                                            child: Icon(
                                              Icons.request_quote,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 20, 0),
                                          child: InkWell(
                                            onTap: () async {
                                              context.pushNamed('FriendsAdd');
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.userFriends,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: AutoSizeText(
                                    'Explore what your friends are up to!',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF8B97A2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 22, 0, 0),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: true,
                              labelColor: Color(0xFFEA7AF4),
                              unselectedLabelColor: Color(0xFF95A1AC),
                              labelStyle: GoogleFonts.getFont(
                                'Open Sans',
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                              indicatorColor: Color(0xFFEA7AF4),
                              indicatorWeight: 3,
                              tabs: [
                                Tab(
                                  text: 'Friends',
                                ),
                                Tab(
                                  text: 'World',
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  StreamBuilder<List<TransactionsRecord>>(
                                    stream: queryTransactionsRecord(
                                      queryBuilder: (transactionsRecord) =>
                                          transactionsRecord
                                              .where('isPublic',
                                                  isEqualTo: true)
                                              .whereArrayContainsAny(
                                                  'usersInvolved',
                                                  feedUserFriendsRecordList
                                                      .map((e) =>
                                                          e.userReference!)
                                                      .toList())
                                              .orderBy('transactionTime',
                                                  descending: true),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: SpinKitSquareCircle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      }
                                      List<TransactionsRecord>
                                          columnTransactionsRecordList =
                                          snapshot.data!;
                                      if (columnTransactionsRecordList
                                          .isEmpty) {
                                        return Center(
                                          child: Image.asset(
                                            'assets/images/EmptyState.png',
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      }
                                      return SingleChildScrollView(
                                        primary: false,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              columnTransactionsRecordList
                                                  .length, (columnIndex) {
                                            final columnTransactionsRecord =
                                                columnTransactionsRecordList[
                                                    columnIndex];
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (columnTransactionsRecord
                                                              .transactionPicture !=
                                                          null &&
                                                      columnTransactionsRecord
                                                              .transactionPicture !=
                                                          '')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 10, 0, 0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  FlutterFlowExpandedImageView(
                                                                image:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      columnTransactionsRecord
                                                                          .transactionPicture!,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                allowRotation:
                                                                    false,
                                                                tag: columnTransactionsRecord
                                                                    .transactionPicture!,
                                                                useHeroAnimation:
                                                                    true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag: columnTransactionsRecord
                                                              .transactionPicture!,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  columnTransactionsRecord
                                                                      .transactionPicture!,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.98,
                                                              height: 300,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        8,
                                                                        0,
                                                                        0),
                                                            child: StreamBuilder<
                                                                UsersRecord>(
                                                              stream: UsersRecord
                                                                  .getDocument(
                                                                      columnTransactionsRecord
                                                                          .sender!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          SpinKitSquareCircle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryColor,
                                                                        size:
                                                                            40,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                final circleImageUsersRecord =
                                                                    snapshot
                                                                        .data!;
                                                                return InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await Navigator
                                                                        .push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType
                                                                            .fade,
                                                                        child:
                                                                            FlutterFlowExpandedImageView(
                                                                          image:
                                                                              Image.network(
                                                                            valueOrDefault<String>(
                                                                              circleImageUsersRecord.photoUrl,
                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                                                                            ),
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                          allowRotation:
                                                                              false,
                                                                          tag: valueOrDefault<
                                                                              String>(
                                                                            circleImageUsersRecord.photoUrl,
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png' +
                                                                                '$columnIndex',
                                                                          ),
                                                                          useHeroAnimation:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Hero(
                                                                    tag: valueOrDefault<
                                                                        String>(
                                                                      circleImageUsersRecord
                                                                          .photoUrl,
                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png' +
                                                                          '$columnIndex',
                                                                    ),
                                                                    transitionOnUserGestures:
                                                                        true,
                                                                    child:
                                                                        Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          circleImageUsersRecord
                                                                              .photoUrl,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            8,
                                                                            12,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    StreamBuilder<
                                                                        UsersRecord>(
                                                                      stream: UsersRecord.getDocument(
                                                                          columnTransactionsRecord
                                                                              .sender!),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 40,
                                                                              height: 40,
                                                                              child: SpinKitSquareCircle(
                                                                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                                                                size: 40,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        final textUsersRecord =
                                                                            snapshot.data!;
                                                                        return AutoSizeText(
                                                                          textUsersRecord
                                                                              .realDisplayName!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'paid',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              fontWeight: FontWeight.w300,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    StreamBuilder<
                                                                        UsersRecord>(
                                                                      stream: UsersRecord.getDocument(
                                                                          columnTransactionsRecord
                                                                              .recipientReference!),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 40,
                                                                              height: 40,
                                                                              child: SpinKitSquareCircle(
                                                                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                                                                size: 40,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        final textUsersRecord =
                                                                            snapshot.data!;
                                                                        return AutoSizeText(
                                                                          textUsersRecord
                                                                              .realDisplayName!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.78,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child:
                                                                      AutoSizeText(
                                                                    columnTransactionsRecord
                                                                        .comment!,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 4),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          16,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            40,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            ToggleIcon(
                                                                          onPressed:
                                                                              () async {
                                                                            final isLikedByElement =
                                                                                currentUserReference;
                                                                            final isLikedByUpdate = columnTransactionsRecord.isLikedBy!.toList().contains(isLikedByElement)
                                                                                ? FieldValue.arrayRemove([
                                                                                    isLikedByElement
                                                                                  ])
                                                                                : FieldValue.arrayUnion([
                                                                                    isLikedByElement
                                                                                  ]);
                                                                            final transactionsUpdateData =
                                                                                {
                                                                              'isLikedBy': isLikedByUpdate,
                                                                            };
                                                                            await columnTransactionsRecord.reference.update(transactionsUpdateData);
                                                                          },
                                                                          value: columnTransactionsRecord
                                                                              .isLikedBy!
                                                                              .toList()
                                                                              .contains(currentUserReference),
                                                                          onIcon:
                                                                              Icon(
                                                                            Icons.favorite_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).errorRed,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          offIcon:
                                                                              Icon(
                                                                            Icons.favorite_border,
                                                                            color:
                                                                                Color(0xFF95A1AC),
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      AutoSizeText(
                                                                        formatNumber(
                                                                          columnTransactionsRecord
                                                                              .isLikedBy!
                                                                              .toList()
                                                                              .length,
                                                                          formatType:
                                                                              FormatType.compact,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText2
                                                                            .override(
                                                                              fontFamily: 'Lexend Deca',
                                                                              color: Color(0xFF8B97A2),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      dateTimeFormat(
                                                                          'relative',
                                                                          columnTransactionsRecord
                                                                              .transactionTime!),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Lexend Deca',
                                                                            color:
                                                                                Color(0xFF8B97A2),
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 3,
                                                        thickness: 1,
                                                        indent: 10,
                                                        color:
                                                            Color(0xFFE1E4E5),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                  StreamBuilder<List<TransactionsRecord>>(
                                    stream: queryTransactionsRecord(
                                      queryBuilder: (transactionsRecord) =>
                                          transactionsRecord
                                              .where('isPublic',
                                                  isEqualTo: true)
                                              .orderBy('transactionTime',
                                                  descending: true),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: SpinKitSquareCircle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      }
                                      List<TransactionsRecord>
                                          columnTransactionsRecordList =
                                          snapshot.data!;
                                      return SingleChildScrollView(
                                        primary: false,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              columnTransactionsRecordList
                                                  .length, (columnIndex) {
                                            final columnTransactionsRecord =
                                                columnTransactionsRecordList[
                                                    columnIndex];
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.uniTag,
                                                              '') !=
                                                          null &&
                                                      valueOrDefault(
                                                              currentUserDocument
                                                                  ?.uniTag,
                                                              '') !=
                                                          '')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  62, 5, 0, 0),
                                                      child:
                                                          AuthUserStreamWidget(
                                                        child: StreamBuilder<
                                                            UsersRecord>(
                                                          stream: UsersRecord
                                                              .getDocument(
                                                                  columnTransactionsRecord
                                                                      .sender!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 40,
                                                                  height: 40,
                                                                  child:
                                                                      SpinKitSquareCircle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiaryColor,
                                                                    size: 40,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            final textUsersRecord =
                                                                snapshot.data!;
                                                            return AutoSizeText(
                                                              textUsersRecord
                                                                  .uniTag!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  if (columnTransactionsRecord
                                                              .transactionPicture !=
                                                          null &&
                                                      columnTransactionsRecord
                                                              .transactionPicture !=
                                                          '')
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 5, 0, 8),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              child:
                                                                  FlutterFlowExpandedImageView(
                                                                image:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      columnTransactionsRecord
                                                                          .transactionPicture!,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                allowRotation:
                                                                    false,
                                                                tag: columnTransactionsRecord
                                                                    .transactionPicture!,
                                                                useHeroAnimation:
                                                                    true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag: columnTransactionsRecord
                                                              .transactionPicture!,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  columnTransactionsRecord
                                                                      .transactionPicture!,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.98,
                                                              height: 300,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        8,
                                                                        0,
                                                                        0),
                                                            child: StreamBuilder<
                                                                UsersRecord>(
                                                              stream: UsersRecord
                                                                  .getDocument(
                                                                      columnTransactionsRecord
                                                                          .sender!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          SpinKitSquareCircle(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .tertiaryColor,
                                                                        size:
                                                                            40,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                final circleImageUsersRecord =
                                                                    snapshot
                                                                        .data!;
                                                                return InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await Navigator
                                                                        .push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType
                                                                            .fade,
                                                                        child:
                                                                            FlutterFlowExpandedImageView(
                                                                          image:
                                                                              Image.network(
                                                                            valueOrDefault<String>(
                                                                              circleImageUsersRecord.photoUrl,
                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                                                                            ),
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                          allowRotation:
                                                                              false,
                                                                          tag: valueOrDefault<
                                                                              String>(
                                                                            circleImageUsersRecord.photoUrl,
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png' +
                                                                                '$columnIndex',
                                                                          ),
                                                                          useHeroAnimation:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Hero(
                                                                    tag: valueOrDefault<
                                                                        String>(
                                                                      circleImageUsersRecord
                                                                          .photoUrl,
                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png' +
                                                                          '$columnIndex',
                                                                    ),
                                                                    transitionOnUserGestures:
                                                                        true,
                                                                    child:
                                                                        Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          circleImageUsersRecord
                                                                              .photoUrl,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    StreamBuilder<
                                                                        UsersRecord>(
                                                                      stream: UsersRecord.getDocument(
                                                                          columnTransactionsRecord
                                                                              .sender!),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 40,
                                                                              height: 40,
                                                                              child: SpinKitSquareCircle(
                                                                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                                                                size: 40,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        final textUsersRecord =
                                                                            snapshot.data!;
                                                                        return AutoSizeText(
                                                                          textUsersRecord
                                                                              .realDisplayName!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'paid',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Open Sans',
                                                                              fontWeight: FontWeight.w300,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    StreamBuilder<
                                                                        UsersRecord>(
                                                                      stream: UsersRecord.getDocument(
                                                                          columnTransactionsRecord
                                                                              .recipientReference!),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 40,
                                                                              height: 40,
                                                                              child: SpinKitSquareCircle(
                                                                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                                                                size: 40,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        final textUsersRecord =
                                                                            snapshot.data!;
                                                                        return AutoSizeText(
                                                                          textUsersRecord
                                                                              .realDisplayName!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Open Sans',
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.78,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .background,
                                                                  ),
                                                                  child:
                                                                      AutoSizeText(
                                                                    columnTransactionsRecord
                                                                        .comment!,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 4),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          16,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            40,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            ToggleIcon(
                                                                          onPressed:
                                                                              () async {
                                                                            final isLikedByElement =
                                                                                currentUserReference;
                                                                            final isLikedByUpdate = columnTransactionsRecord.isLikedBy!.toList().contains(isLikedByElement)
                                                                                ? FieldValue.arrayRemove([
                                                                                    isLikedByElement
                                                                                  ])
                                                                                : FieldValue.arrayUnion([
                                                                                    isLikedByElement
                                                                                  ]);
                                                                            final transactionsUpdateData =
                                                                                {
                                                                              'isLikedBy': isLikedByUpdate,
                                                                            };
                                                                            await columnTransactionsRecord.reference.update(transactionsUpdateData);
                                                                          },
                                                                          value: columnTransactionsRecord
                                                                              .isLikedBy!
                                                                              .toList()
                                                                              .contains(currentUserReference),
                                                                          onIcon:
                                                                              Icon(
                                                                            Icons.favorite_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).errorRed,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          offIcon:
                                                                              Icon(
                                                                            Icons.favorite_border,
                                                                            color:
                                                                                Color(0xFF95A1AC),
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      AutoSizeText(
                                                                        formatNumber(
                                                                          columnTransactionsRecord
                                                                              .isLikedBy!
                                                                              .toList()
                                                                              .length,
                                                                          formatType:
                                                                              FormatType.compact,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText2
                                                                            .override(
                                                                              fontFamily: 'Lexend Deca',
                                                                              color: Color(0xFF8B97A2),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        AutoSizeText(
                                                                      dateTimeFormat(
                                                                          'relative',
                                                                          columnTransactionsRecord
                                                                              .transactionTime!),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Lexend Deca',
                                                                            color:
                                                                                Color(0xFF8B97A2),
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 3,
                                                        thickness: 1,
                                                        indent: 10,
                                                        color:
                                                            Color(0xFFE1E4E5),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0.9),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if ((currentUserDisplayName != null &&
                                  currentUserDisplayName != '') &&
                              (valueOrDefault(
                                          currentUserDocument
                                              ?.choosenInstitution,
                                          '') !=
                                      null &&
                                  valueOrDefault(
                                          currentUserDocument
                                              ?.choosenInstitution,
                                          '') !=
                                      '') &&
                              (valueOrDefault(currentUserDocument?.iban, '') !=
                                      null &&
                                  valueOrDefault(currentUserDocument?.iban, '') !=
                                      '') &&
                              (valueOrDefault(currentUserDocument?.countryCode, '') !=
                                      null &&
                                  valueOrDefault(currentUserDocument?.countryCode, '') !=
                                      '') &&
                              (valueOrDefault(currentUserDocument?.postCode, '') !=
                                      null &&
                                  valueOrDefault(currentUserDocument?.postCode, '') !=
                                      '')) {
                            context.pushNamed('Recepients_money_transferCopy');
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Something is missing('),
                                  content: Text(
                                      'Please make sure all your profile data is filled in and try again'),
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
                            return;
                          }
                        },
                        text: 'Request',
                        options: FFButtonOptions(
                          width: 140,
                          height: 40,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        showLoadingIndicator: false,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0.9),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final usersUpdateData = createUsersRecordData(
                              firstTransactionMade: true,
                            );
                            await currentUserReference!.update(usersUpdateData);
                            if ((currentUserDisplayName != null &&
                                    currentUserDisplayName != '') &&
                                (valueOrDefault(currentUserDocument?.choosenInstitution, '') !=
                                        null &&
                                    valueOrDefault(
                                            currentUserDocument
                                                ?.choosenInstitution,
                                            '') !=
                                        '') &&
                                (valueOrDefault(currentUserDocument?.iban, '') !=
                                        null &&
                                    valueOrDefault(currentUserDocument?.iban, '') !=
                                        '') &&
                                (valueOrDefault(currentUserDocument?.countryCode, '') !=
                                        null &&
                                    valueOrDefault(
                                            currentUserDocument?.countryCode,
                                            '') !=
                                        '') &&
                                (valueOrDefault(currentUserDocument?.postCode, '') !=
                                        null &&
                                    valueOrDefault(
                                            currentUserDocument?.postCode, '') !=
                                        '')) {
                              context.pushNamed('Recepients_money_transfer');
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Something is missing('),
                                    content: Text(
                                        'Please make sure all your profile data is filled in and try again'),
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
                              return;
                            }
                          },
                          text: 'Pay',
                          options: FFButtonOptions(
                            width: 140,
                            height: 40,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          showLoadingIndicator: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (valueOrDefault<bool>(
                      currentUserDocument?.firstTransactionMade, false) ==
                  false)
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: AuthUserStreamWidget(
                    child: TestTransCardWidget(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
