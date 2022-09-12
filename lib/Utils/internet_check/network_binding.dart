import 'package:get/get.dart';

import 'getx_network_manager.dart';

class NetworkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
  }
}