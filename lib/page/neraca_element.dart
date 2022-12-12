import 'package:flutter/material.dart';
import 'package:um_mobile/model/neraca.dart';
import 'package:um_mobile/provider/utility_provider.dart';
import 'package:um_mobile/repository/auth_repository.dart';
import 'package:um_mobile/repository/neraca_repository.dart';

class NeracaElement extends StatefulWidget {
  const NeracaElement({super.key});

  @override
  State<NeracaElement> createState() => _NeracaElementState();
}

class _NeracaElementState extends State<NeracaElement> {
  bool auth = false;
  List<Neraca> neracas = [];

  void checkSessionToken() async {
    setState(() {
      auth = false;
    });
    await AuthRepository().getToken().then((value) {
      if (value != null) {
        setState(() {
          auth = true;
        });
        getNeraca();
      } else {
        setState(() {
          auth = false;
        });
      }
    });
  }

  void getNeraca() async {
    UtilityProvider.showLoadingDialog(context);
    await NeracaRepository().getNeraca().then((value) {
      if (value.code == 200) {
        setState(() {
          neracas = value.news;
        });
      } else {
        setState(() {
          neracas = [];
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
                itemCount: neracas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          "K : ${neracas[index].kredit} / D : ${neracas[index].debet} / S : ${neracas[index].saldo}"),
                      subtitle: Text("${neracas[index].namaTransaksi}"),
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
