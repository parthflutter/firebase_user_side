import 'package:get/get.dart';

import '../view/cart_screen.dart';
import '../view/favouritescreen.dart';
import '../view/menuscreen.dart';

class Home_controller extends GetxController{
  RxInt i=0.obs;
  RxList screenList = [menuscreen(), cartscreen(), fscreen()].obs;
  RxInt qty=1.obs;


}