import 'package:um_mobile/model/neraca.dart';
import 'package:um_mobile/provider/api_provider.dart';
import 'package:um_mobile/repository/auth_repository.dart';

class NeracaResponse {
  int code;
  String message;
  List<Neraca> news;
  NeracaResponse(
      {required this.code, required this.message, required this.news});
}

class NeracaRepository {
  //get api with dio
  Future<NeracaResponse> getNeraca() async {
    var _session = null;
    await AuthRepository().getToken().then((value) {
      if (value != null) {
        _session = value;
      }
    });
    if (_session == null) {
      return NeracaResponse(
          news: [], message: "Silahkan Login Terlebih Dahulu", code: 402);
    }
    var response = await ApiProvider.post(
        "https://scraping-um-node-js.vercel.app/siam/neraca",
        {"_session": "${_session}"},
        {}).then((value) {
      if (value.statusCode == 200) {
        List<Neraca> news = [];
        for (var item in value.data) {
          news.add(Neraca.fromJson(item));
        }
        return NeracaResponse(news: news, message: "success", code: 200);
      } else {
        return NeracaResponse(
            news: [],
            message: "${value.statusMessage}",
            code: value.statusCode!);
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      return NeracaResponse(news: [], message: "${error}", code: 500);
    });

    return response;
  }
}
