import 'package:flutter/material.dart';
import 'package:tms/theme/color.dart';

Widget countdown({void Function()? onEnd, required DateTime datetime}) {
  Duration expiration = datetime.difference(DateTime.now());
  int minutes = expiration.inMinutes.remainder(60);
  int seconds = expiration.inSeconds.remainder(60);

  return TweenAnimationBuilder<Duration>(
    duration: Duration(minutes: minutes, seconds: seconds),
    tween: Tween(begin: Duration(minutes: minutes, seconds: seconds), end: Duration.zero),
    onEnd: onEnd,
    builder: (BuildContext context, Duration value, Widget? child) {
      int minutes = value.inMinutes;
      int seconds = value.inSeconds % 60;
      String time = '0$minutes : ${seconds.toString().padLeft(2, '0')}';

      return Flexible(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'รหัสยืนยันการใช้งาน จะหมดอายุใน ',
            style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Kanit'),
            children: [
              TextSpan(text: time, style: const TextStyle(color: ThemeColor.primaryColor, fontWeight: FontWeight.bold)),
              const TextSpan(text: ' นาที\nหลังทำการขอรหัส หากไม่ได้รับรหัสผ่าน\nกรุณากดขอรหัสผ่านใหม่อีกครั้ง')
            ],
          ),
        ),
      );
    },
  );
}
