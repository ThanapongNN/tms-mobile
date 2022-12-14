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

    if (Store.newsModel != null && Store.listNewsHome.isEmpty) {
      for (var data in Store.newsModel!.value.data!) {
        Store.listNewsHome.addAll(data!.lists!);
      }

      Store.listNewsHome.removeWhere((news) => !news.startDate.isBefore(DateTime.now()) && news.endDate.isAfter(DateTime.now()));
    }
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
              (Store.productGroupModel != null && Store.userAccountModel != null)
                  ? Column(children: [
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF414F5C),
                        child: Column(children: [
                          text(
                              'ยอดขายเดือน ${DateFormat('MMMM ${Store.productGroupModel!.value.data![0]!.lastUpdate!.year + 543}').format(Store.productGroupModel!.value.data![0]!.lastUpdate!)}',
                              color: Colors.white),
                          const SizedBox(height: 5),
                          text(
                            DateFormat('ข้อมูลถึงวันที่ dd/MM/${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal()),
                            color: Colors.white,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 105,
                            child: boxHeadStatus(
                                image: 'assets/images/true.svg',
                                content: 'ยอดขายรวมทุกสินค้า',
                                quantity: '${Store.productGroupModel!.value.data![0]!.totalCount}'),
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
                      Column(
                        children: Store.productGroupModel!.value.data![0]!.homeDisplay!.map<Widget>((homeDisplay) {
                          return listProductGroup(
                            icon: homeDisplay!.iconName!,
                            title: homeDisplay.order!,
                            quantity: '${homeDisplay.orderTotal!}',
                            seeDetail: !(homeDisplay.orderTotal! == 0),
                            unit: homeDisplay.unit!,
                            detail: homeDisplay.serviceCampaign!,
                          );
                        }).toList(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Store.currentIndex.value = 1;
                          Store.indexProductGroup.value = 0;
                        },
                        child: text('ดูยอดขายทั้งหมด', color: const Color(0xFF2F80ED), decoration: TextDecoration.underline),
                      ).paddingSymmetric(vertical: 15),
                    ])
                  : NoDataPage(onPressed: () async {
                      await firstLoginRequest();
                      setState(() {});
                    }),
              if (Store.listNewsHome.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text('ข่าวสารและแคมเปญ', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10, horizontal: 20),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: Store.listNewsHome.length,
                          itemBuilder: (BuildContext context, int index) {
                            return boxNews(
                              image: Store.listNewsHome[index].thumbnailUrl,
                              content: Store.listNewsHome[index].headline,
                              onTap: () => Get.to(() => DetailPage(Store.listNewsHome[index])),
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
