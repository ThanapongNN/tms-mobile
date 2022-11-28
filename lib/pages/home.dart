import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms/models/all_product_group.model.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/pages/news/new_detail.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_head_status.dart';
import 'package:tms/widgets/box_news.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/list_product_group.dart';
import 'package:tms/widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> items = [];
  List iconHead = ["assets/images/phone.svg", "assets/images/sim2.svg", "assets/images/tv.svg", "assets/images/coin.svg"];

  ProductGroupModel productGroupModel = ProductGroupModel.fromJson(Store.productGroup);
  AllProductGroupModel allProductGroupModel = AllProductGroupModel.fromJson(Store.allProductGroup);

  int indexProductGroup = 0;

  @override
  void initState() {
    super.initState();

    int sum = 0;
    for (var e in productGroupModel.productGroup) {
      sum += int.parse(e.salesTotal);
    }

    items.add(boxHeadStatus(image: 'assets/images/true.svg', content: 'ยอดขายรวมทุกสินค้า', quantity: '$sum'));

    items.addAll(productGroupModel.productGroup.map((e) {
      return boxHeadStatus(image: iconHead[productGroupModel.productGroup.indexOf(e)], content: e.product, quantity: e.salesTotal);
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: (Store.userAccount.isNotEmpty)
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: ThemeColor.primaryColor,
                    child: Row(children: [
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage('assets/images/no_avatar.png'),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: text(
                          'คุณ${Store.userAccountModel.value.account.name} ${Store.userAccountModel.value.account.surname}',
                          color: Colors.white,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/pinlocation.svg', color: Colors.white).paddingOnly(right: 5),
                      FittedBox(child: text(Store.userAccountModel.value.account.partnerName, color: Colors.white))
                    ]),
                  )
                : const SizedBox(),
          ),
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              Container(
                width: double.infinity,
                color: const Color(0xFF414F5C),
                child: Column(
                  children: [
                    text('สรุปยอดขายของคุณ', color: Colors.white),
                    const SizedBox(height: 5),
                    text(
                      DateFormat('ข้อมูลถึงวันที่ dd/MM/${DateTime.now().year + 543} HH:mm', 'th').format(DateTime.now().toLocal()),
                      color: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Store.currentIndex.value = 1;
                        Store.indexProductGroup.value = indexProductGroup;
                      },
                      child: CarouselSlider(
                        items: items,
                        options: CarouselOptions(
                          height: 90,
                          initialPage: Store.indexProductGroup.value,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) => indexProductGroup = index,
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(vertical: 15),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allProductGroupModel.allProductGroup.length,
                      itemBuilder: (context, index) {
                        return listProductGroup(
                            icon: allProductGroupModel.allProductGroup[index].icon,
                            title: allProductGroupModel.allProductGroup[index].order,
                            quantity: allProductGroupModel.allProductGroup[index].orderTotal,
                            unit: allProductGroupModel.allProductGroup[index].unit,
                            detail: allProductGroupModel.allProductGroup[index].serviceCampaign,
                            seeDetail: (allProductGroupModel.allProductGroup[index].orderTotal == '0') ? false : true);
                      },
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => Store.currentIndex.value = 1,
                      child: text('ดูยอดขายทั้งหมด', color: const Color(0xFF2F80ED), decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text('ข่าวสารและแคมเปญเด่น', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10, horizontal: 20),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return boxNews(
                              image: 'assets/images/promotion.png',
                              content: 'ทรูให้เครื่องฟรี ที่ 7-Eleven เมื่อเปิด เบอร์ ใหม่รายเดือนหรือใช้ เบอร์เดิม WIKO Y82',
                              onTap: () => Get.to(() => const NewDetail()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
