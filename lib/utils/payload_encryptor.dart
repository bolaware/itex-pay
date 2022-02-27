import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:math';


void main() {
  final sEncKey = PayloadEncryptor.createCryptoRandomString();
  final encKey = PayloadEncryptor.encryptKey(sEncKey);
  final encryptedData = PayloadEncryptor.test(sEncKey);
  print("--------------");
  print(sEncKey);
  print("--------------");
  print(encKey);
  print("--------------");
  print(encryptedData);
}

class PayloadEncryptor {

  static String test(String sEncKey) {
    String plainText = "{"
        + "    \"transaction\": {"
        + "        \"merchantreference\": \"M1603t798eg9106an10m_y12\","
        + "        \"callbackurl\": \"https://google.com\","
        + "        \"redirecturl\": \"https://yahoo.com\","
        + "        \"authoption\": \"3DS\","
        + "        \"paymentmethod\": \"card\""
        + "    },"
        + "    \"order\": {"
        + "        \"amount\": \"10\","
        + "        \"description\": \"test\","
        + "        \"currency\": \"NGN\","
        + "        \"country\": \"NG\""
        + "    },"
        + "    \"source\": {"
        + "        \"customer\": {"
        + "            \"firstname\": \"test\","
        + "            \"lastname\": \"user\","
        + "            \"email\": \"o@k.com\","
        + "            \"msisdn\": \"0807654453\","
        + "            \"card\": {"
        + "                \"number\": \"4508750015741019\","
        + "                \"expirymonth\": \"05\","
        + "                \"expiryyear\": \"22\","
        + "                \"cvv\": \"100\""
        + "            },"
        + "            \"device\": {"
        + "                \"fingerprint\": \"and_23456789h5678i9oj89\","
        + "                \"ip\": \"127.0.0.1\""
        + "            }"
        + "        }"
        + "    }"
        + "}";
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(Key.fromUtf8(sEncKey), mode: AESMode.ecb));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String encryptKey(String data) {

    RSAPublicKey publicKey = RSAKeyParser().parse(
        "-----BEGIN PUBLIC KEY-----\n"
        "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhH+MZ36XzmNttGqREsUKYXjkxedhs5W6FyGztWQ76yNN3C2ytXAAUZeuSm+6G0iXx0UehJ9+YETPiPBH4LVR11r4BZfCQB7FC5i0h1Y1L9JcSvqKDT1un/kcEjgSn3yPP6RaFTbROm5bzdQ46wp2bNP+tFdSP7kWB7XvJZlEVONEY58z1tUBfhCMMk0FhK4hsKqufaDj5VFRZk7+o+d6nV5v6WEs7C+F4uMlqhCXZEuSmfApAFKHrDoKkYOxS54HKZkWc6W5kWOW1N6nn6jkqfjtYkhrcCwrSomcbm/0C/FFi2PsnehrSDjPU85cSzeFg9kjzsrbsi1AeO0NDQE2OQIDAQAB\n"
        "-----END PUBLIC KEY-----");
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(data);
    return encrypted.base64;
  }

  static final Random _random = Random.secure();

  static String createCryptoRandomString([int length = 16]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(128));

    return base64Url.encode(values);
  }
}