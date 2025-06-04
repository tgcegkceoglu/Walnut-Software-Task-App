import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

//strapide auth. saving, setting and reading operations of incoming jwt token with hive
class TokenService {
  static final TokenService instance = TokenService._internal();

  static const String _boxName = 'secureBox';
  static const String _tokenKey = 'jwt_token';

  Box? _box;
  bool _isInitialized = false;

  TokenService._internal();
 
  
  Future<void> _initHive() async {
    if (!_isInitialized) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      _isInitialized = true;
    }
  }

  Future<void> init() async {
    if (_box == null || !_box!.isOpen) {
      await _initHive();
      _box = await Hive.openBox(_boxName);
    }
  }

  Future<void> saveToken(String token) async {
    await init();
    await _box!.put(_tokenKey, token);
  }

  Future<String?> getToken() async {
    await init();
    return _box!.get(_tokenKey);
  }

  Future<void> deleteToken() async {
    await init();
    await _box!.delete(_tokenKey);
  }

  Future<void> closeBox() async {
    await _box?.close();
    _box = null;
  }
}
