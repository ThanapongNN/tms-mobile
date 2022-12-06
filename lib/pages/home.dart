// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms/apis/request/product_group.request.dart';
import 'package:tms/pages/news/new_detail.dart';
import 'package:tms/pages/no_data.dart';
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
  List iconHead = ["assets/images/phone.svg", "assets/images/tv.svg", "assets/images/coin.svg", "assets/images/sim2.svg"];

  int indexProductGroup = 0;

  @override
  void initState() {
    super.initState();

    // if (Store.productGroupModel != null) {
    //   items.add(boxHeadStatus(
    //       image: 'assets/images/true.svg', content: 'ยอดขายรวมทุกสินค้า', quantity: '${Store.productGroupModel!.value.data[0].totalCount}'));

    //   items.addAll(Store.productGroupModel!.value.data[0].productGroup.map((e) {
    //     return boxHeadStatus(
    //         image: (e.product == 'ยอดเบอร์' || e.product == 'ยอดขายเบอร์')
    //             ? "assets/images/sim2.svg"
    //             : (e.product == 'ยอดมือถือ' || e.product == "ยอดขายมือถือ")
    //                 ? "assets/images/phone.svg"
    //                 : (e.product == 'เติมเงินเติมเน็ต' || e.product == "ยอดขายเติมเงินเติมเน็ต")
    //                     ? "assets/images/coin.svg"
    //                     : (e.product == 'เน็ตบ้านและทีวี' || e.product == "ยอดสมัครเน็ตบ้านและทีวี")
    //                         ? "assets/images/tv.svg"
    //                         : "assets/images/true.svg",
    //         content: e.product,
    //         quantity: '${e.salesTotal}');
    //   }).toList());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100),
          centerTitle: true,
          bottom: (Store.userAccountModel != null)
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
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
                          'คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}',
                          color: Colors.white,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/pinlocation.svg', color: Colors.white).paddingOnly(right: 5),
                      FittedBox(child: text(Store.userAccountModel!.value.account.partnerName, color: Colors.white))
                    ]),
                  ))
              : null,
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              (Store.productGroupModel != null && Store.userAccountModel != null)
                  ? Column(children: [
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF414F5C),
                        child: Column(children: [
                          text(
                              'ยอดขายเดือน ${DateFormat('MMMM ${Store.productGroupModel!.value.data[0].lastUpdate.year + 543}').format(Store.productGroupModel!.value.data[0].lastUpdate)}',
                              color: Colors.white),
                          const SizedBox(height: 5),
                          text(
                            DateFormat(
                              'ข้อมูลถึงวันที่ dd/MM/${Store.productGroupModel!.value.data[0].lastUpdate.year + 543} HH:mm',
                              'th',
                            ).format(Store.productGroupModel!.value.data[0].lastUpdate.toLocal()),
                            color: Colors.white,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 90,
                            child: boxHeadStatus(
                                image: 'assets/images/true.svg',
                                content: 'ยอดขายรวมทุกสินค้า',
                                quantity: '${Store.productGroupModel!.value.data[0].totalCount}'),
                          )
                          // GestureDetector(
                          //     onTap: () {
                          //       Store.currentIndex.value = 1;
                          //       Store.indexProductGroup.value = indexProductGroup;
                          //     },
                          //     child:
                          //     CarouselSlider(
                          //       items: items,
                          //       options: CarouselOptions(
                          //         height: 90,
                          //         initialPage: Store.indexProductGroup.value,
                          //         enableInfiniteScroll: false,
                          //         onPageChanged: (index, reason) => indexProductGroup = index,
                          //       ),
                          //     ),
                          //     ),
                        ]).paddingSymmetric(vertical: 15),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                String icon = 'assets/images/phone_with_sim.svg';
                                if (index == 0) {}
                                icon = 'assets/images/sim.svg';

                                return listProductGroup(
                                  icon: icon,
                                  title: Store.productGroupModel!.value.data[0].productGroup[0].salesOrder[index].order,
                                  quantity: '${Store.productGroupModel!.value.data[0].productGroup[0].salesOrder[index].orderTotal}',
                                  unit: Store.productGroupModel!.value.data[0].productGroup[0].salesOrder[index].unit,
                                  detail: Store.productGroupModel!.value.data[0].productGroup[0].salesOrder[index].serviceCampaign,
                                  seeDetail:
                                      (Store.productGroupModel!.value.data[0].productGroup[0].salesOrder[index].orderTotal == 0) ? false : true,
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                Store.currentIndex.value = 1;
                                Store.indexProductGroup.value = 0;
                              },
                              child: text('ดูยอดขายทั้งหมด', color: const Color(0xFF2F80ED), decoration: TextDecoration.underline),
                            ).paddingSymmetric(vertical: 15),
                          ],
                        ),
                      ),
                    ])
                  : NoDataPage(onPressed: () async {
                      await callAccountProductGroup(Store.encryptedEmployeeId.value);
                      setState(() {
                        if (Store.productGroupModel != null) {
                          items.add(boxHeadStatus(
                              image: 'assets/images/true.svg',
                              content: 'ยอดขายรวมทุกสินค้า',
                              quantity: '${Store.productGroupModel!.value.data[0].totalCount}'));

                          items.addAll(Store.productGroupModel!.value.data[0].productGroup.map((e) {
                            return boxHeadStatus(
                                image: iconHead[Store.productGroupModel!.value.data[0].productGroup.indexOf(e)],
                                content: e.product,
                                quantity: '${e.salesTotal}');
                          }).toList());
                        }
                      });
                    }),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text('ข่าวสารและแคมเปญเด่น (mock)', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10, horizontal: 20),
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
