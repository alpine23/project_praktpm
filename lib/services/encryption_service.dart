import 'package:cryptography/cryptography.dart';

class EncryptionService {
  final Cipher cipher = AesGcm.with256bits();
  final List<int> secretKeyBytes = List.generate(32, (i) => i);
  final List<int> nonce = List.generate(12, (i) => i);

  Future<List<int>> encrypt(String text) async {
    final secretKey = SecretKey(secretKeyBytes);
    final secretBox = await cipher.encrypt(
      text.codeUnits,
      secretKey: secretKey,
      nonce: nonce,
    );
    return secretBox.concatenation();
  }

  Future<String> decrypt(List<int> encrypted) async {
    final secretKey = SecretKey(secretKeyBytes);
    final secretBox = SecretBox.fromConcatenation(
      encrypted,
      nonceLength: nonce.length,
      macLength: 16,
    );
    final clearText = await cipher.decrypt(
      secretBox,
      secretKey: secretKey,
    );
    return String.fromCharCodes(clearText);
  }
}
