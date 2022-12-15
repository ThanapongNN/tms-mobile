import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/state_management.dart';

Future<void> callFirstLogin(String employeeId) async {
  await Future.wait([
    Call.raw(
      method: Method.get,
      url: '$host/user/v1/accounts/$employeeId',
      headers: Authorization.token,
      showDialog: false,
    ).then((userAccount) {
      if (userAccount.success) Store.userAccountModel = UserAccountModel.fromJson(userAccount.response).obs;
    }),
    Call.raw(
      method: Method.get,
      url: '$host/product-group/v1/productGroup/$employeeId',
      headers: Authorization.token,
      showDialog: false,
    ).then((productGroup) {
      if (productGroup.success) Store.productGroupModel = ProductGroupModel.fromJson(productGroup.response).obs;
    })
  ]);

  Store.newsModel = NewsModel.fromJson({
    "code": "200",
    "description": "SUCCESS",
    "transactionId": "transactionId",
    "data": [
      {
        "group_name": "new",
        "name_th": "ข่าวสารใหม่ๆ",
        "name_en": "new!!!",
        "icon": "speaker",
        "lists": [
          {
            "name_th": "รับซิมทรูเซเว่นฟรี",
            "name_en": "get_sim_7-11_free",
            "source_type": "VDO",
            "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/uc?export=download&id=1A088jRcGJQjuP6zmZ5ogsOEFWZAzM3ib",
            "start_date": "2022-02-24T17:17:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "name_en": "change prepaid sim to monthly sim",
            "source_type": "PDF",
            "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/uc?export=download&id=1Ph02aoThudstesV2DlNerNKVqnV14xty",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "รับซิมทรูเซเว่นฟรี",
            "name_en": "get_sim_7-11_free",
            "source_type": "IMG",
            "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "name_en": "change prepaid sim to monthly sim",
            "source_type": "PDF",
            "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1Ph02aoThudstesV2DlNerNKVqnV14xty/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "รับซิมทรูเซเว่นฟรี",
            "name_en": "get_sim_7-11_free",
            "source_type": "VDO",
            "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1A088jRcGJQjuP6zmZ5ogsOEFWZAzM3ib/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "name_en": "change prepaid sim to monthly sim",
            "source_type": "PDF",
            "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1Ph02aoThudstesV2DlNerNKVqnV14xty/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          }
        ]
      },
      {
        "group_name": "promotion_and_sim",
        "name_th": "โปรโมชั่นและซิมต่างๆ",
        "name_en": "Promotion and sim",
        "icon": "sim",
        "lists": [
          {
            "name_th": "รับซิมทรูเซเว่นฟรี",
            "name_en": "get_sim_7-11_free",
            "source_type": "VDO",
            "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1A088jRcGJQjuP6zmZ5ogsOEFWZAzM3ib/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "name_en": "change prepaid sim to monthly sim",
            "source_type": "PDF",
            "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1Ph02aoThudstesV2DlNerNKVqnV14xty/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "รับซิมทรูเซเว่นฟรี",
            "name_en": "get_sim_7-11_free",
            "source_type": "VDO",
            "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1A088jRcGJQjuP6zmZ5ogsOEFWZAzM3ib/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "name_en": "change prepaid sim to monthly sim",
            "source_type": "PDF",
            "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1Ph02aoThudstesV2DlNerNKVqnV14xty/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "รับซิมทรูเซเว่นฟรี",
            "name_en": "get_sim_7-11_free",
            "source_type": "VDO",
            "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1A088jRcGJQjuP6zmZ5ogsOEFWZAzM3ib/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          },
          {
            "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "name_en": "change prepaid sim to monthly sim",
            "source_type": "PDF",
            "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
            "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
            "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
            "source_url": "https://drive.google.com/file/d/1Ph02aoThudstesV2DlNerNKVqnV14xty/view",
            "start_date": "2022-02-24T07:00:00+07:00",
            "end_date": "2022-12-31T07:00:00+07:00"
          }
        ]
      }
    ]
  }).obs;
}
