import 'package:tennist/src/helper/StorageHelper.dart';

class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();
  factory AuthHelper() => _instance;

  AuthHelper._internal() {
    //초기화 코드
    print("LoginHelper loaded...");
  }

  static Future<bool> hasToken() async {
    String accessToken = await StorageHelper.readStorage('access_token');
    String refreshToken = await StorageHelper.readStorage('refresh_token');
    print('accessToken : $accessToken');
    print('refreshToken : $refreshToken');

    //리프레쉬 토큰이 또는 액세스 토큰이 없다면 로그아웃된것이다.
    if ((accessToken == null) || refreshToken == null) {
      await AuthHelper.deleteAllToken();
      return false;
    }
    return true;
  }

  static Future<void> saveLoginToken(String accessT, String refreshT) async {
    try {
      await saveAccessToken(accessT);
      await saveRefreshToken(refreshT);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<void> saveAccessToken(String accessT) async {
    try {
      await StorageHelper.writeStorage('access_token', accessT);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> saveRefreshToken(String refreshT) async {
    try {
      await StorageHelper.writeStorage('refresh_token', refreshT);
    } catch (e) {
      throw e;
    }
  }

  static Future<String> getAccessToken() async {
    return await StorageHelper.readStorage('access_token');
  }

  static Future<bool> hasRefreshToken() async {
    String refreshToken = await StorageHelper.readStorage('refresh_token');
    return false;
  }

  static Future<bool> requestAccessToken() async {
    //TODO : 엑세스 토큰 저장
    String refreshToken = await StorageHelper.readStorage('refresh_token');

    return true;
  }

  static Future<bool> requestAccessTokenPermitted() async {
    String refreshToken = await StorageHelper.readStorage('refresh_token');
  }

  static Future<void> deleteAllToken() async {
    await StorageHelper.deleteStorage('access_token');
    await StorageHelper.deleteStorage('refresh_token');
  }

  static Future<bool> isLogin() async {
    //1.내부 저장소에 엑세스 토큰을 불러온다
    String accessToken = await StorageHelper.readStorage('access_token');
    String refreshToken = await StorageHelper.readStorage('refresh_token');
    print('accessToken : $accessToken');
    print('refreshToken : $refreshToken');

    //리프레쉬 토큰이 또는 액세스 토큰이 없다면 로그아웃된것이다.
    if ((accessToken == null) || refreshToken == null) {
      await AuthHelper.deleteAllToken();
      return false;
    }

    //엑세스 토큰 허가 여부체크를 체크하고 허용일시 로그인임을 전달
    bool isAccessTokenPermitted =
        await AuthHelper.requestAccessTokenPermitted();
    if (isAccessTokenPermitted) return true;

    //리프레쉬 토큰으로 엑세스 토큰 요청 -엑세스 토큰이 저장되고 온다.
    bool isPermitted = await requestAccessToken();
    if (isPermitted) return true;

    await AuthHelper.deleteAllToken();
    return false;
  }
}
