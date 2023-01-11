import 'package:get/state_manager.dart';
import 'package:tms/models/forgot_password.model.dart';
import 'package:tms/models/learning.model.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/models/user_roles.model.dart';

//ตัวแปรกองกลาง
class Store extends GetxController {
  static RxBool drawer = false.obs;

  static RxInt currentIndex = 0.obs;
  static RxInt indexProductGroup = 0.obs;
  static RxInt indexMonth = 0.obs;

  static RxDouble heightSliverAppBar = 0.0.obs;

  static RxList listNewsHome = [].obs;

  static RxMap<String, dynamic> partnerTypes = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> registerBody = <String, dynamic>{}.obs;

  static RxString encryptedEmployeeId = ''.obs;
  static RxString deviceSerial = ''.obs;
  static RxString userID = ''.obs;
  static RxString selectedProductGroup = ''.obs;
  static RxString otpRefID = ''.obs;
  static RxString token = ''.obs;
  static RxString version = ''.obs;

  //STORE MODEL
  static Rx<ForgotPasswordModel>? forgotPasswordModel;
  static Rx<LearningModel>? learningModel;
  static Rx<NewsModel>? newsModel;
  static Rx<ProductGroupModel>? productGroupModel;
  static Rx<UserAccountModel>? userAccountModel;
  static Rx<UserRolesModel>? userRolesModel;

  static void clearState() {
    drawer.value = false;

    currentIndex.value = 0;
    indexProductGroup.value = 0;
    indexMonth.value = 0;

    listNewsHome.clear();

    encryptedEmployeeId.value = '';
    userID.value = '';
    selectedProductGroup.value = '';
    token.value = '';

    learningModel = null;
    newsModel = null;
    productGroupModel = null;
    userAccountModel = null;
  }
}
