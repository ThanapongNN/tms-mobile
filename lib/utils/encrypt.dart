import 'package:encrypt/encrypt.dart';

encrypt(String plainText) {
  final encrypter = Encrypter(AES(Key.fromUtf8("14hm40kvejz48wwtq7rvskhj6sjd9dp6"), mode: AESMode.cbc));
  final iv = IV.fromUtf8("bv7w4caq6seelok4");

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base16;
}
