import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:training_ecommerce/screen/produk/productDetailApi.dart';

class DynamicLinkServices {
  Future handleDynamicLink(BuildContext context) async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    handleDeepLink(context, data);
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      handleDeepLink(context, dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed : ${e.message}');
    });
  }

  void handleDeepLink(BuildContext context, PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var post = deepLink.pathSegments.contains("getProductDetail.php");
      if (post) {
        var idProduct = deepLink.queryParameters['idProduct'];
        print(idProduct);
        if (idProduct != null) {
          Route route = MaterialPageRoute(
              builder: (context) => ProductDetailAPI(idProduct));

          Navigator.push(context, route);
        }
      }
    }
  }

  Future<Uri> createdShareLink(String idProduct) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://ecommercecc.page.link',
      link: Uri.parse(
          'http://192.168.65.2/ecommerce/api/getProductDetail.php?idProduct=$idProduct'),
      androidParameters: AndroidParameters(
        packageName: 'com.ecommercecc.android',
      ),
    );

    final link = await parameters.buildUrl();
    final ShortDynamicLink shortDynamicLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortDynamicLink.shortUrl;
  }
}
