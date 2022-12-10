import 'package:flutter/material.dart';
import 'package:um_mobile/model/jadwal.dart';
import 'package:um_mobile/provider/utility_provider.dart';
import 'package:um_mobile/repository/auth_repository.dart';
import 'package:um_mobile/repository/jadwal_repository.dart';

class JadwalElement extends StatefulWidget {
  const JadwalElement({super.key});

  @override
  State<JadwalElement> createState() => _JadwalElementState();
}

class _JadwalElementState extends State<JadwalElement> {
  bool auth = false;
  List<Jadwal> jadwals = [];

  void checkSessionToken() async {
    setState(() {
      auth = false;
    });
    await AuthRepository().getToken().then((value) {
      if (value != null) {
        setState(() {
          auth = true;
        });
        getJadwal();
      } else {
        setState(() {
          auth = false;
        });
      }
    });
  }

  void getJadwal() async {
    UtilityProvider.showLoadingDialog(context);
    await JadwalRepository().getJadwal().then((value) {
      if (value.code == 200) {
        setState(() {
          jadwals = value.news;
        });
      } else {
        setState(() {
          jadwals = [];
        });
      }
    });
    Navigator.pop(context);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSessionToken();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height - 150;
    return RefreshIndicator(
        child: (auth)
            ? ListView.builder(
                itemCount: jadwals.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "${jadwals[index].kode} - ${jadwals[index].nama}"),
                      subtitle: Text(
                          "${jadwals[index].hari} - ${jadwals[index].jam} / Dosen : ${jadwals[index].dosen}"),
                    ),
                  );
                })
            : Center(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height,
                        child: Center(
                          child: Text("Silahkan Login Terlebih Dahulu"),
                        ),
                      );
                    }),
              ),
        onRefresh: () async {
          checkSessionToken();
        });
  }
}
