import 'package:um_mobile/model/jadwal.dart';
import 'package:um_mobile/provider/api_provider.dart';
import 'package:um_mobile/repository/auth_repository.dart';

class JadwalResponse {
  int code;
  String message;
  List<Jadwal> news;
  JadwalResponse(
      {required this.code, required this.message, required this.news});
}

class JadwalRepository {
  //get api with dio
  Future<JadwalResponse> getJadwal() async {
    var _session = null;
    await AuthRepository().getToken().then((value) {
      if (value != null) {
        _session = value;
      }
    });
    if (_session == null) {
      return JadwalResponse(
          news: [], message: "Silahkan Login Terlebih Dahulu", code: 402);
    }
    var response = await ApiProvider.post(
        "https://scraping-um-node-js.vercel.app/siam/jadwal-kuliah",
        {"_session": "${_session}"},
        {}).then((value) {
      if (value.statusCode == 200) {
        List<Jadwal> news = [];
        for (var item in value.data) {
          news.add(Jadwal.fromJson(item));
        }
        return JadwalResponse(news: news, message: "success", code: 200);
      } else {
        return JadwalResponse(
            news: [],
            message: "${value.statusMessage}",
            code: value.statusCode!);
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      return JadwalResponse(news: [], message: "${error}", code: 500);
    });

    return response;
  }
}
