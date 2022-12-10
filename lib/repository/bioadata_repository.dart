import 'package:um_mobile/model/biodata.dart';
import 'package:um_mobile/provider/api_provider.dart';
import 'package:um_mobile/repository/auth_repository.dart';

class BiodataResponse {
  int code;
  String message;
  Biodata? biodata;
  BiodataResponse({required this.code, required this.message, this.biodata});
}

class BiodataRepository {
  //get api with dio
  Future<BiodataResponse> getBiodata() async {
    var _session = null;
    await AuthRepository().getToken().then((value) {
      if (value != null) {
        _session = value;
      }
    });
    if (_session == null) {
      return BiodataResponse(
          message: "Silahkan Login Terlebih Dahulu", code: 402);
    }
    var response = await ApiProvider.post(
        "https://scraping-um-node-js.vercel.app/siam/biodata",
        {"_session": "${_session}"},
        {}).then((value) {
      if (value.statusCode == 200) {
        return BiodataResponse(
            biodata: Biodata.fromJson(value.data),
            message: "success",
            code: 200);
      } else {
        return BiodataResponse(
            message: "${value.statusMessage}", code: value.statusCode!);
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      return BiodataResponse(message: "${error}", code: 500);
    });

    return response;
  }
}
