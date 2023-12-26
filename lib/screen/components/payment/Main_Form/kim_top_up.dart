import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:http/http.dart' as http;
import '../../../../afa/components/contants.dart';
import '../../../Home/Home.dart';

const _baseUrl =
    "https://www.oneclickonedollar.com/laravel_kfa_2023/public/api";

const _kProductIds = [
  'kfa_1c1d_csv1',
  'kfa_1c1d_csv3',
  'kfa_1c1d_csv52',
  'kfa_1c1d_csv62',
  'kfa_1c1d_csv8',
  'kfa_1c1d_csv10',
  'kfa_1c1d_10ow',
  'kfa_1c1d_30om2',
];

class TopUp extends StatefulWidget {
  const TopUp({
    super.key,
    this.set_phone,
    this.up_point,
    this.id_user,
    this.set_id_user,
    this.set_email,
  });
  final String? set_phone;
  final String? up_point;
  final String? id_user;
  final String? set_id_user;
  final String? set_email;

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  bool _isAvailable = false;
  int _point = 0;
  bool _productLoading = false;
  bool _purchasePending = false;
  String? _error;
  List<ProductDetails> _products = [];

  @override
  void initState() {
    super.initState();
    _initializePoint();
    _initializeStore();
    _subscription = _iap.purchaseStream.listen(_purchaseUpdateHandler);
  }

  void _initializePoint() async {
    final uri = Uri.parse(
        "$_baseUrl/check_dateVpoint?id_user_control=${widget.set_id_user}");
    final res = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      setState(() {
        _point = int.parse(jsonData['vpoint'].toString());
      });
    }
  }

  void _initializeStore() async {
    _productLoading = true;

    final isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _error = 'Store currently not available';
        _productLoading = false;
      });
      return;
    }

    // Perform some plateform specific requirement
    if (Platform.isIOS) {
      final iosPlatformAddition =
          _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }

    // Fetch product ids
    final results = await _iap.queryProductDetails(_kProductIds.toSet());
    setState(() => _productLoading = false);

    // Print some not found product ids
    debugPrint("Not Found given ids: ${results.notFoundIDs}");

    // Got error from fetching the product
    if (results.error != null) {
      setState(() => _error = results.error!.message);
      return;
    }

    setState(() {
      _products = results.productDetails;
      _isAvailable = isAvailable;
      _error = null;
    });
  }

  void _purchaseUpdateHandler(List<PurchaseDetails> details) async {
    for (final purchase in details) {
      log(purchase.toString());

      if (purchase.status == PurchaseStatus.pending) {
        setState(() {
          _purchasePending = true;
        });
      }

      if (purchase.status == PurchaseStatus.canceled) {
        setState(() => _purchasePending = false);
      }

      if (purchase.pendingCompletePurchase) {
        setState(() => _purchasePending = false);
        await InAppPurchase.instance.completePurchase(purchase);
        log('Purchase pendingCompletePurchase');
      }

      if (purchase.status == PurchaseStatus.purchased) {
        log('Purchased in app');
        final product =
            _products.firstWhereOrNull((e) => e.id == purchase.productID);
        if (product == null) return;

        final amount = product.price.replaceAll("\$", "").replaceAll(" ", "");

        final isPurchaseValid = await _verifyPurchased(
          userId: widget.id_user ?? "",
          productId: purchase.productID,
          amount: amount,
          verificationData: purchase.verificationData.serverVerificationData,
        );

        if (isPurchaseValid && context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success'),
                content: Text('Successfully purchase ${product.description}'),
              );
            },
          );
        }
      }
    }
  }

  Future<bool> _verifyPurchased({
    required String productId,
    required String userId,
    required String amount,
    required String verificationData,
  }) async {
    try {
      const url = "$_baseUrl/verifyInAppPurchase";

      final headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      final request = {
        "id_user_control": userId,
        "product_id": productId,
        "amount": amount,
        "verification_data": verificationData,
        "platform": Platform.isIOS ? "IOS" : "Android",
      };

      final res = await http.post(
        Uri.parse(url),
        headers: headers,
        body: request,
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final message = data["message"];
        final status = data["status"];

        log("Verify purchase message: $message with status: $status detail: $data");
        return message == "success";
      }

      throw res.body;
    } catch (e, str) {
      log(e.toString(), stackTrace: str);
      return false;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    if (Platform.isIOS) {
      final iosPlatformAddition =
          _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stack = Stack(
      children: [
        if (_error == null)
          ListView(
            children: [
              _buildConnectionCheckTile(),
              _buildProductList(),
              //handleSuccessful(purchaseDetail!),
            ],
          )
        else
          Center(child: Text(_error!)),
        if (_purchasePending == true) ...[
          const Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite_new,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.all(5),
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/v.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$_point',
              style: TextStyle(
                fontSize: 30,
                color: Colors.amber[800],
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, const HomePage1());
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        actions: [
          GFIconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () {},
            icon: const Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 20,
            ),
            color: Colors.white,
            type: GFButtonType.outline2x,
            size: 10,
            iconSize: 30.0,
            disabledColor: Colors.white,
            shape: GFIconButtonShape.circle,
          ),
        ],
      ),
      body: stack,
    );
  }

  Card _buildConnectionCheckTile() {
    if (_productLoading) {
      return const Card(child: ListTile(title: Text('Trying to connect...')));
    }
    final storeHeader = ListTile(
      leading: Icon(
        _isAvailable ? Icons.check : Icons.block,
        color: _isAvailable ? Colors.red : ThemeData.light().colorScheme.error,
      ),
      title: Text(
        'The store is ${_isAvailable ? 'available' : 'unavailable'}.',
      ),
    );
    final children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll(<Widget>[
        const Divider(),
        ListTile(
          title: Text(
            'Not connected',
            style: TextStyle(color: ThemeData.light().colorScheme.error),
          ),
          subtitle: const Text(
            'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.',
          ),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    if (_productLoading) {
      return const Card(
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Fetching products...'),
        ),
      );
    }

    final productList = _products.map(
      (product) {
        return ListTile(
          onTap: () async {
            setState(() => _purchasePending = true);

            try {
              final param = PurchaseParam(productDetails: product);
              await _iap.buyConsumable(
                purchaseParam: param,
                autoConsume: Platform.isIOS,
              );
            } catch (e, str) {
              log(e.toString(), stackTrace: str);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }

            setState(() => _purchasePending = false);
          },
          title: Container(
            margin: const EdgeInsets.all(6),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 7,
                  offset: Offset(1.0, 7.0),
                ),
              ],
              border: Border.all(width: 1),
            ),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child: Image.asset("assets/images/v.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.description.toString(),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.amber[800],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  product.price.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 242, 11, 134),
                    decorationStyle: TextDecorationStyle.solid,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).toList();

    return Card(
      child: Column(
        children: [
          const Divider(),
          ...productList,
        ],
      ),
    );
  }
}

class IOSPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
    SKPaymentTransactionWrapper transaction,
    SKStorefrontWrapper storefront,
  ) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
