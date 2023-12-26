// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:getwidget/components/button/gf_icon_button.dart';
// import 'package:getwidget/shape/gf_icon_button_shape.dart';
// import 'package:getwidget/types/gf_button_type.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
// import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
// import 'package:itckfa/afa/components/contants.dart';
// import 'package:itckfa/screen/Home/Home.dart';
// import 'package:itckfa/screen/Property/Screen_Page/consumable_store.dart';
// import 'package:http/http.dart' as http;

// // Auto-consume must be true on iOS.
// // To try without auto-consume on another platform, change `true` to `false` here.
// final bool _kAutoConsume = Platform.isIOS || true;

// const String _kConsumableIdv1 = 'kfa_1c1d_csv1';
// const String _kConsumableIdv3 = 'kfa_1c1d_csv3';
// const String _kConsumableIdv5 = 'kfa_1c1d_csv52';
// const String _kConsumableIdv6 = 'kfa_1c1d_csv62';
// const String _kConsumableIdv8 = 'kfa_1c1d_csv8';
// const String _kConsumableIdv10 = 'kfa_1c1d_csv10';
// const String _kConsumableIdv10vc1w = 'kfa_1c1d_10ow';
// const String _kConsumableIdv40vc1m = 'kfa_1c1d_30om2';
// const List<String> _kProductIds = <String>[
//   _kConsumableIdv1,
//   _kConsumableIdv3,
//   _kConsumableIdv5,
//   _kConsumableIdv6,
//   _kConsumableIdv8,
//   _kConsumableIdv10,
//   _kConsumableIdv10vc1w,
//   _kConsumableIdv40vc1m,
// ];

// class TopUp extends StatefulWidget {
//   const TopUp({
//     super.key,
//     this.set_phone,
//     this.up_point,
//     this.id_user,
//     this.set_id_user,
//     this.set_email,
//   });
//   final String? set_phone;
//   final String? up_point;
//   final String? id_user;
//   final String? set_id_user;
//   final String? set_email;
//   @override
//   State<TopUp> createState() => _TopUpState();
// }

// class _TopUpState extends State<TopUp> {
//   int v_point = 0;
//   Future<void> get_count() async {
//     final response = await http.get(
//       Uri.parse(
//         'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/check_dateVpoint?id_user_control=${widget.set_id_user}',
//       ),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//       setState(() {
//         v_point = int.parse(jsonData['vpoint'].toString());
//       });
//     }
//   }

//   Future<void> check() async {
//     get_count();
//   }

//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   List<String> _notFoundIds = <String>[];
//   List<ProductDetails> _products = <ProductDetails>[];
//   List<PurchaseDetails> _purchases = <PurchaseDetails>[];
//   List<String> _consumables = <String>[];
//   bool _isAvailable = false;
//   bool _purchasePending = false;
//   bool _loading = true;
//   String? _queryProductError;

//   @override
//   void initState() {
//     final Stream<List<PurchaseDetails>> purchaseUpdated =
//         _inAppPurchase.purchaseStream;
//     _subscription = purchaseUpdated.listen(
//       (List<PurchaseDetails> purchaseDetailsList) {
//         // _listenToPurchaseUpdated(purchaseDetailsList);
//         completepurchase(purchaseDetailsList);
//       },
//       onDone: () {
//         _subscription.cancel();
//       },
//       onError: (Object error) {
//         // handle error here.
//       },
//     );
//     initStoreInfo();
//     check();
//     super.initState();
//   }

//   Future<void> initStoreInfo() async {
//     final bool isAvailable = await _inAppPurchase.isAvailable();
//     if (!isAvailable) {
//       setState(() {
//         _isAvailable = isAvailable;
//         _products = <ProductDetails>[];
//         _purchases = <PurchaseDetails>[];
//         _notFoundIds = <String>[];
//         //_consumables = <String>[];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }

//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
//     }

//     final ProductDetailsResponse productDetailResponse =
//         await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
//     if (productDetailResponse.error != null) {
//       setState(() {
//         _queryProductError = productDetailResponse.error!.message;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = <PurchaseDetails>[];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _consumables = <String>[];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }

//     if (productDetailResponse.productDetails.isEmpty) {
//       setState(() {
//         _queryProductError = null;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = <PurchaseDetails>[];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _consumables = <String>[];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }

//     final List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _isAvailable = isAvailable;
//       _products = productDetailResponse.productDetails;
//       _notFoundIds = productDetailResponse.notFoundIDs;
//       _consumables = consumables;
//       _purchasePending = false;
//       _loading = false;
//     });
//   }

//   @override
//   void dispose() {
//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       iosPlatformAddition.setDelegate(null);
//     }
//     _subscription.cancel();
//     super.dispose();
//   }

//   PurchaseDetails? purchaseDetail;
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> stack = <Widget>[];

//     if (_queryProductError == null) {
//       stack.add(
//         ListView(
//           children: <Widget>[
//             _buildConnectionCheckTile(),
//             _buildProductList(),
//             //handleSuccessful(purchaseDetail!),
//             //_buildConsumableBox(),
//             //_buildRestoreButton(),
//           ],
//         ),
//       );
//     } else {
//       stack.add(
//         Center(
//           child: Text(_queryProductError!),
//         ),
//       );
//     }
//     if (_purchasePending) {
//       stack.add(
//         const Stack(
//           children: <Widget>[
//             Opacity(
//               opacity: 0.3,
//               child: ModalBarrier(dismissible: false, color: Colors.grey),
//             ),
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//           ],
//         ),
//       );
//     }

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: kwhite_new,
//           title: Row(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(left: 15),
//                 padding: const EdgeInsets.all(5),
//                 height: 30,
//                 width: 30,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/v.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 '$v_point',
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: Colors.amber[800],
//                 ),
//               ),
//             ],
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context, const HomePage1());
//             },
//             icon: const Icon(
//               Icons.chevron_left,
//               size: 35,
//               color: Colors.white,
//             ),
//           ),
//           elevation: 0.0,
//           actions: [
//             GFIconButton(
//               padding: const EdgeInsets.all(1),
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.question_mark,
//                 color: Colors.white,
//                 size: 20,
//               ),
//               color: Colors.white,
//               type: GFButtonType.outline2x,
//               size: 10,
//               iconSize: 30.0,
//               disabledColor: Colors.white,
//               shape: GFIconButtonShape.circle,
//             ),
//           ],
//         ),
//         body: Stack(
//           children: stack,
//         ),
//       ),
//     );
//   }

//   Card _buildConnectionCheckTile() {
//     if (_loading) {
//       return const Card(child: ListTile(title: Text('Trying to connect...')));
//     }
//     final Widget storeHeader = ListTile(
//       leading: Icon(
//         _isAvailable ? Icons.check : Icons.block,
//         color: _isAvailable ? Colors.red : ThemeData.light().colorScheme.error,
//       ),
//       title:
//           Text('The store is ${_isAvailable ? 'available' : 'unavailable'}.'),
//     );
//     final List<Widget> children = <Widget>[storeHeader];

//     if (!_isAvailable) {
//       children.addAll(<Widget>[
//         const Divider(),
//         ListTile(
//           title: Text(
//             'Not connected',
//             style: TextStyle(color: ThemeData.light().colorScheme.error),
//           ),
//           subtitle: const Text(
//             'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.',
//           ),
//         ),
//       ]);
//     }
//     return Card(child: Column(children: children));
//   }

//   Card _buildProductList() {
//     if (_loading) {
//       return const Card(
//         child: ListTile(
//           leading: CircularProgressIndicator(),
//           title: Text('Fetching products...'),
//         ),
//       );
//     }
//     if (!_isAvailable) {
//       return const Card();
//     }
//     //const ListTile productHeader = ListTile(title: Text('Products for Sale'));
//     final List<ListTile> productList = <ListTile>[];
//     if (_notFoundIds.isNotEmpty) {
//       productList.add(
//         ListTile(
//           title: Text(
//             '[${_notFoundIds.join(", ")}] not found',
//             style: TextStyle(color: ThemeData.light().colorScheme.error),
//           ),
//           subtitle: const Text(
//             'This app needs special configuration to run. Please see example/README.md for instructions.',
//           ),
//         ),
//       );
//     }

//     // This loading previous purchases code is just a demo. Please do not use this as it is.
//     // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
//     // We recommend that you use your own server to verify the purchase data.
//     final Map<String, PurchaseDetails> purchases =
//         Map<String, PurchaseDetails>.fromEntries(
//       _purchases.map((PurchaseDetails purchase) {
//         if (purchase.pendingCompletePurchase) {
//           _inAppPurchase.completePurchase(purchase);
//         }
//         return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
//       }),
//     );
//     productList.addAll(
//       _products.map(
//         (ProductDetails productDetails) {
//           final PurchaseDetails? previousPurchase =
//               purchases[productDetails.id];
//           return ListTile(
//             //title:
//             // subtitle: Text(
//             //   productDetails.description,
//             // ),
//             title: previousPurchase != null && Platform.isIOS
//                 ? IconButton(
//                     onPressed: () => confirmPriceChange(context),
//                     icon: const Icon(Icons.upgrade),
//                   )
//                 : InkWell(
//                     onTap: () {
//                       late PurchaseParam purchaseParam;

//                       if (Platform.isAndroid) {
//                         // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
//                         // verify the latest status of you your subscription by using server side receipt validation
//                         // and update the UI accordingly. The subscription purchase status shown
//                         // inside the app may not be accurate.
//                         // final GooglePlayPurchaseDetails? oldSubscription =
//                         //     _getOldSubscription(productDetails, purchases);
//                         // purchaseParam = GooglePlayPurchaseParam(
//                         //     productDetails: productDetails,
//                         //     changeSubscriptionParam: (oldSubscription != null)
//                         //         ? ChangeSubscriptionParam(
//                         //             oldPurchaseDetails: oldSubscription,
//                         //             prorationMode: ProrationMode
//                         //                 .immediateWithTimeProration,
//                         //           )
//                         //         : null);
//                       } else {
//                         purchaseParam = PurchaseParam(
//                           productDetails: productDetails,
//                         );
//                       }

//                       if (productDetails.id == _kConsumableIdv5) {
//                         _inAppPurchase.buyConsumable(
//                           purchaseParam: purchaseParam,
//                           autoConsume: _kAutoConsume,
//                         );
//                       } else {
//                         _inAppPurchase.buyNonConsumable(
//                           purchaseParam: purchaseParam,
//                         );
//                       }
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(6),
//                       height: MediaQuery.of(context).size.height * 0.1,
//                       width: MediaQuery.of(context).size.height * 0.1,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(80),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 7,
//                             offset: Offset(1.0, 7.0),
//                           ),
//                         ],
//                         border: Border.all(
//                           width: 1,
//                         ),
//                       ),
//                       alignment: Alignment.topCenter,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 15,
//                                 height: 15,
//                                 child: Image.asset("assets/images/v.png"),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   productDetails.description.toString(),
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: Colors.amber[800],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             productDetails.price.toString(),
//                             style: const TextStyle(
//                               fontSize: 17,
//                               color: Color.fromARGB(255, 242, 11, 134),
//                               decorationStyle: TextDecorationStyle.solid,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//           );
//         },
//       ),
//     );

//     return Card(
//       child: Column(children: <Widget>[const Divider()] + productList),
//     );
//   }

//   Future<void> confirmPriceChange(BuildContext context) async {
//     // Price changes for Android are not handled by the application, but are
//     // instead handled by the Play Store. See
//     // https://developer.android.com/google/play/billing/price-changes for more
//     // information on price changes on Android.
//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
//     }
//   }

//   //complete purchase
//   void completepurchase(List<PurchaseDetails> purchaseDetiallist) {
//     // ignore: avoid_function_literals_in_foreach_calls
//     purchaseDetiallist.forEach((PurchaseDetails purchaseDetails) async {
//       print('This function was called! $purchaseDetails');

//       if (purchaseDetails.status == PurchaseStatus.purchased ||
//           purchaseDetails.status == PurchaseStatus.restored) {
//         print('Have been purchased');
//       }
//       if (purchaseDetails.pendingCompletePurchase) {
//         await InAppPurchase.instance.completePurchase(purchaseDetails);
//         print('Purchase make complete');
//       }
//     });
//   }

//   handleSuccessful(PurchaseDetails purchaseDetails) {
//     if (purchaseDetails.productID == _kConsumableIdv1) {
//       return const Text("V1");
//     } else if (purchaseDetails.productID == _kConsumableIdv3) {
//       return const Text("V3");
//     } else if (purchaseDetails.productID == _kConsumableIdv5) {
//       return const Text("V5");
//     } else if (purchaseDetails.productID == _kConsumableIdv10) {
//       return const Text("V10");
//     } else if (purchaseDetails.productID == _kConsumableIdv10vc1w) {
//       return const Text("V10v1w");
//     } else {
//       return const Text("null");
//     }
//   }
// }

// /// Example implementation of the
// /// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
// ///
// /// The payment queue delegate can be implementated to provide information
// /// needed to complete transactions.
// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(
//     SKPaymentTransactionWrapper transaction,
//     SKStorefrontWrapper storefront,
//   ) {
//     return true;
//   }

//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }
