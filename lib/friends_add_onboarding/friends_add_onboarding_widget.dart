import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/push_notifications/push_notifications_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class FriendsAddOnboardingWidget extends StatefulWidget {
  const FriendsAddOnboardingWidget({Key? key}) : super(key: key);

  @override
  _FriendsAddOnboardingWidgetState createState() =>
      _FriendsAddOnboardingWidgetState();
}

class _FriendsAddOnboardingWidgetState
    extends State<FriendsAddOnboardingWidget> {
  List<UsersRecord>? algoliaSearchResults = [];
  TextEditingController? textController;
  ScrollController? columnController;
  PagingController<DocumentSnapshot?, UsersRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  ScrollController? listViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    columnController = ScrollController();
    textController = TextEditingController();
    listViewController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    columnController?.dispose();
    textController?.dispose();
    listViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<UserFriendsRecord>>(
      stream: queryUserFriendsRecord(
        parent: currentUserReference,
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
        List<UserFriendsRecord> friendsAddOnboardingUserFriendsRecordList =
            snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: AutoSizeText(
              'Find your friends by name',
              style: FlutterFlowTheme.of(context).title3,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: columnController,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                onChanged: (_) => EasyDebounce.debounce(
                                  'textController',
                                  Duration(milliseconds: 100),
                                  () async {
                                    setState(() => algoliaSearchResults = null);
                                    await UsersRecord.search(
                                      term: textController!.text,
                                    )
                                        .then((r) => algoliaSearchResults = r)
                                        .onError((_, __) =>
                                            algoliaSearchResults = [])
                                        .whenComplete(() => setState(() {}));
                                  },
                                ),
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Search friends...',
                                  labelStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).gray200,
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 44,
                                icon: Icon(
                                  Icons.search_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (textController!.text == null ||
                          textController!.text == '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: PagedListView<DocumentSnapshot<Object?>?,
                              UsersRecord>(
                            pagingController: () {
                              final Query<Object?> Function(Query<Object?>)
                                  queryBuilder = (usersRecord) => usersRecord;
                              if (_pagingController != null) {
                                final query =
                                    queryBuilder(UsersRecord.collection);
                                if (query != _pagingQuery) {
                                  // The query has changed
                                  _pagingQuery = query;
                                  _streamSubscriptions
                                      .forEach((s) => s?.cancel());
                                  _streamSubscriptions.clear();
                                  _pagingController!.refresh();
                                }
                                return _pagingController!;
                              }

                              _pagingController =
                                  PagingController(firstPageKey: null);
                              _pagingQuery =
                                  queryBuilder(UsersRecord.collection);
                              _pagingController!
                                  .addPageRequestListener((nextPageMarker) {
                                queryUsersRecordPage(
                                  queryBuilder: (usersRecord) => usersRecord,
                                  nextPageMarker: nextPageMarker,
                                  pageSize: 25,
                                  isStream: true,
                                ).then((page) {
                                  _pagingController!.appendPage(
                                    page.data,
                                    page.nextPageMarker,
                                  );
                                  final streamSubscription =
                                      page.dataStream?.listen((data) {
                                    final itemIndexes = _pagingController!
                                        .itemList!
                                        .asMap()
                                        .map((k, v) =>
                                            MapEntry(v.reference.id, k));
                                    data.forEach((item) {
                                      final index =
                                          itemIndexes[item.reference.id];
                                      final items =
                                          _pagingController!.itemList!;
                                      if (index != null) {
                                        items.replaceRange(
                                            index, index + 1, [item]);
                                        _pagingController!.itemList = {
                                          for (var item in items)
                                            item.reference: item
                                        }.values.toList();
                                      }
                                    });
                                    setState(() {});
                                  });
                                  _streamSubscriptions.add(streamSubscription);
                                });
                              });
                              return _pagingController!;
                            }(),
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            builderDelegate:
                                PagedChildBuilderDelegate<UsersRecord>(
                              // Customize what your widget looks like when it's loading the first page.
                              firstPageProgressIndicatorBuilder: (_) => Center(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: SpinKitSquareCircle(
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 40,
                                  ),
                                ),
                              ),

                              itemBuilder: (context, _, listViewIndex) {
                                final listViewUsersRecord =
                                    _pagingController!.itemList![listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 4, 16, 8),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).gray200,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x32000000),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(26),
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                listViewUsersRecord.photoUrl,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                                              ),
                                              width: 36,
                                              height: 36,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      AutoSizeText(
                                                        listViewUsersRecord
                                                            .realDisplayName!,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              final friendRequestsCreateData =
                                                  createFriendRequestsRecordData(
                                                userReference:
                                                    currentUserReference,
                                              );
                                              await FriendRequestsRecord
                                                      .createDoc(
                                                          listViewUsersRecord
                                                              .reference)
                                                  .set(
                                                      friendRequestsCreateData);
                                              triggerPushNotification(
                                                notificationTitle:
                                                    'Someone sent you a friend request ',
                                                notificationText:
                                                    'Click to accept',
                                                notificationSound: 'default',
                                                userRefs: [
                                                  listViewUsersRecord.reference
                                                ],
                                                initialPageName: 'FriendsAdd',
                                                parameterData: {},
                                              );
                                              await listViewController
                                                  ?.animateTo(
                                                0,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                curve: Curves.ease,
                                              );
                                            },
                                            text: 'Add',
                                            options: FFButtonOptions(
                                              width: 70,
                                              height: 36,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryColor,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (textController!.text != null &&
                          textController!.text != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Builder(
                            builder: (context) {
                              if (algoliaSearchResults!
                                      .map((e) => e)
                                      .toList() ==
                                  null) {
                                return Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: SpinKitSquareCircle(
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 40,
                                    ),
                                  ),
                                );
                              }
                              final algSearchRes =
                                  algoliaSearchResults!.map((e) => e).toList();
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: algSearchRes.length,
                                itemBuilder: (context, algSearchResIndex) {
                                  final algSearchResItem =
                                      algSearchRes[algSearchResIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 4, 16, 8),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .gray200,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x32000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  algSearchResItem.photoUrl,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/facil-pago-9prsfv/assets/47h1l2nocmk6/icons8-user-50.png',
                                                ),
                                                width: 36,
                                                height: 36,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        AutoSizeText(
                                                          algSearchResItem
                                                              .realDisplayName!,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                final friendRequestsCreateData =
                                                    createFriendRequestsRecordData(
                                                  userReference:
                                                      currentUserReference,
                                                );
                                                await FriendRequestsRecord
                                                        .createDoc(
                                                            algSearchResItem
                                                                .reference)
                                                    .set(
                                                        friendRequestsCreateData);
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      'Someone sent you a friend request ',
                                                  notificationText:
                                                      'Click to accept',
                                                  notificationSound: 'default',
                                                  userRefs: [
                                                    algSearchResItem.reference
                                                  ],
                                                  initialPageName: 'FriendsAdd',
                                                  parameterData: {},
                                                );
                                              },
                                              text: 'Add',
                                              options: FFButtonOptions(
                                                width: 70,
                                                height: 36,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryColor,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                controller: listViewController,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0.85),
                  child: FFButtonWidget(
                    onPressed: () async {
                      final userFriendsCreateData = createUserFriendsRecordData(
                        userReference: currentUserReference,
                      );
                      await UserFriendsRecord.createDoc(currentUserReference!)
                          .set(userFriendsCreateData);

                      context.goNamed('BankName');
                    },
                    text: 'Wrap  up!',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                              ),
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
      },
    );
  }
}
