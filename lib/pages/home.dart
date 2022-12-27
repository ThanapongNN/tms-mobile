// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/pages/detail.dart';
import 'package:tms/pages/no_data.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/ga_log.dart';
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

  // @override
  // void initState() {
  //   super.initState();

  // if (Store.productGroupModel != null) {
  //   items.add(boxHeadStatus(
  //       image: 'assets/images/true.svg', content: 'ยอดขายรวมทุกสินค้า', quantity: '${Store.productGroup['data'][0].totalCount}'));

  //   items.addAll(Store.productGroup['data'][0].productGroup.map((e) {
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
  // }

  @override
  void initState() {
    super.initState();
    GALog.content('home-view');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100),
          bottom: (Store.userAccountModel != null)
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: ThemeColor.primaryColor,
                    child: FittedBox(
                      child: Row(children: [
                        const CircleAvatar(
                          backgroundColor: Colors.red,
                          backgroundImage: AssetImage('assets/images/no_avatar.png'),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 280,
                          child: text(
                            'คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}',
                            color: Colors.white,
                          ),
                        ),
                        SvgPicture.asset('assets/images/pinlocation.svg', color: Colors.white).paddingOnly(right: 5),
                        text(Store.userAccountModel!.value.account.partnerName, color: Colors.white)
                      ]),
                    ),
                  ))
              : null,
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              (Store.productGroup.isNotEmpty && Store.userAccountModel != null)
                  ? Column(children: [
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF414F5C),
                        child: Column(children: [
                          text(
                              'ยอดขายเดือน ${DateFormat('MMMM ${DateTime.parse(Store.productGroup['data'][0]['lastUpdate']).year + 543}').format(DateTime.parse(Store.productGroup['data'][0]['lastUpdate']))}',
                              color: Colors.white),
                          const SizedBox(height: 5),
                          text(
                            DateFormat(
                              'ข้อมูลถึงวันที่ dd/MM/${DateTime.parse(Store.productGroup['data'][0]['lastUpdate']).year + 543}',
                              'th',
                            ).format(DateTime.parse(Store.productGroup['data'][0]['lastUpdate']).toLocal()),
                            color: Colors.white,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 105,
                            child: boxHeadStatus(
                                image: 'assets/images/true.svg',
                                content: 'ยอดขายรวมทุกสินค้า',
                                quantity: '${Store.productGroup['data'][0]['totalCount']}'),
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
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                String icon = 'assets/images/sim.svg';

                                //ตอนนี้ hard code อนาคตรอ back end ส่งคีย์มาบอกว่าจะเอาอะไรขึ้นโชว์หน้าแรก
                                switch (index) {
                                  case 0:
                                    icon = 'assets/images/phone_with_sim.svg';
                                    return listProductGroup(
                                      icon: icon,
                                      title: Store.productGroup['data'][0]['productGroup'][1]['salesOrder'][0]['order'],
                                      quantity: '${Store.productGroup['data'][0]['productGroup'][1]['salesOrder'][0]['orderTotal']}',
                                      unit: Store.productGroup['data'][0]['productGroup'][1]['salesOrder'][0]['unit'],
                                      detail: Store.productGroup['data'][0]['productGroup'][1]['salesOrder'][0]['serviceCampaign'],
                                      seeDetail: !(Store.productGroup['data'][0]['productGroup'][1]['salesTotal'] == 0),
                                    );
                                  case 1:
                                    return listProductGroup(
                                      icon: icon,
                                      title: Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][1]['order'],
                                      quantity: '${Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][1]['orderTotal']}',
                                      unit: 'รายการ',
                                      detail: Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][1]['serviceCampaign'],
                                      seeDetail: !(Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][1]['orderTotal'] == 0),
                                    );
                                  case 2:
                                    return listProductGroup(
                                      icon: icon,
                                      title: Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][0]['order'],
                                      quantity: '${Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][0]['orderTotal']}',
                                      unit: 'รายการ',
                                      detail: Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][0]['serviceCampaign'],
                                      seeDetail: !(Store.productGroup['data'][0]['productGroup'][0]['salesOrder'][0]['orderTotal'] == 0),
                                    );
                                  case 3:
                                    icon = 'assets/images/coin_฿.svg';
                                    return listProductGroup(
                                      icon: icon,
                                      title: Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][0]['order'],
                                      quantity: '${Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][0]['orderTotal']}',
                                      unit: Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][0]['unit'],
                                      detail: Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][0]['serviceCampaign'] +
                                          Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][0]['serviceCampaign'],
                                      seeDetail: !(Store.productGroup['data'][0]['productGroup'][3]['salesTotal'] == 0),
                                    );
                                  case 4:
                                    icon = 'assets/images/coin_฿.svg';
                                    return listProductGroup(
                                      icon: icon,
                                      title: Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][1]['order'],
                                      quantity: '${Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][1]['orderTotal']}',
                                      unit: Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][1]['unit'],
                                      detail: Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][1]['serviceCampaign'] +
                                          Store.productGroup['data'][0]['productGroup'][3]['salesOrder'][1]['serviceCampaign'],
                                      seeDetail: !(Store.productGroup['data'][0]['productGroup'][3]['salesTotal'] == 0),
                                    );
                                  default:
                                    return const SizedBox();
                                }
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
                      await firstLoginRequest();
                      setState(() {});
                    }),
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
                        itemCount: Store.newsModel!.value.data[0].lists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return boxNews(
                            image: Store.newsModel!.value.data[0].lists[index].thumbnailUrl,
                            content: Store.newsModel!.value.data[0].lists[index].subHeadline,
                            onTap: () => Get.to(() => DetailPage(Store.newsModel!.value.data[0].lists[index])),
                          );
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
