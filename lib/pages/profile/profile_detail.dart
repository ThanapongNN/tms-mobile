import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tms/widgets/text.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('ข้อมูลของคุณ', fontSize: 20),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            maxRadius: 40,
            child: text('AH'),
          ),
          const SizedBox(height: 10),
          text('ศนันธฉัตร  ธนพัฒน์พิศาล'),
          text('7-11 สาขาเจริญนคร 27'),
          const SizedBox(height: 10),
          box(svgicon: 'assets/icons/pinlocation.svg', title: 'สถานที่ทำงาน', content: '7-11 สาขาเจริญนคร 27', tail: true, texttail: '1122334455'),
          box(svgicon: 'assets/icons/Person.svg', title: 'สถานที่ทำงาน', content: '7-11 สาขาเจริญนคร 27'),
          box(svgicon: 'assets/icons/cake.svg', title: 'สถานที่ทำงาน', content: '7-11 สาขาเจริญนคร 27'),
          box(svgicon: 'assets/icons/Phone.svg', title: 'สถานที่ทำงาน', content: '7-11 สาขาเจริญนคร 27'),
          box(svgicon: 'assets/icons/Envelope open.svg', title: 'สถานที่ทำงาน', content: '7-11 สาขาเจริญนคร 27')
        ]),
      ),
    );
  }
}

Widget box({
  required String svgicon,
  required String title,
  required String content,
  bool tail = false,
  String texttail = '',
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade400)),
    child: ListTile(
      leading: SvgPicture.asset(svgicon, height: 40),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: text(title)),
              if (tail) FittedBox(child: text('1122334455')),
            ],
          ),
          text(content),
        ],
      ),
    ).paddingSymmetric(vertical: 10),
  ).paddingSymmetric(horizontal: 20, vertical: 10);
}
