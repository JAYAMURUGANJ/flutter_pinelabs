import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save a value to secure storage
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read a value from secure storage
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Delete a value from secure storage
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all data from secure storage
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}