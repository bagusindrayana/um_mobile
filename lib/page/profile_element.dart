import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:um_mobile/model/biodata.dart';
import 'package:um_mobile/provider/utility_provider.dart';
import 'package:um_mobile/repository/auth_repository.dart';
import 'package:um_mobile/repository/bioadata_repository.dart';

class ProfileElement extends StatefulWidget {
  const ProfileElement({super.key});

  @override
  State<ProfileElement> createState() => _ProfileElementState();
}

class _ProfileElementState extends State<ProfileElement> {
  bool auth = false;
  Biodata? biodata = null;

  void getBioadata() async {
    UtilityProvider.showLoadingDialog(context);
    await BiodataRepository().getBiodata().then((value) {
      if (value.code == 200) {
        setState(() {
          biodata = value.biodata;
        });
      } else {
        setState(() {
          biodata = null;
        });
      }
    });
    Navigator.pop(context);
  }

  void logout() async {
    UtilityProvider.showLoadingDialog(context);
    await AuthRepository().logout().then((value) {
      if (value.status == 200) {
        setState(() {
          auth = false;
          biodata = null;
        });
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/');
        });
      } else {
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      }
    });
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
    Future.delayed(Duration.zero, () {
      this.getBioadata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (biodata != null)
        ? Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: biodata!.getFoto(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${biodata!.namalengkap}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${biodata!.programstudi}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('NIM'),
                subtitle: Text("${biodata!.nim}"),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Status'),
                subtitle: Text("${biodata!.status}"),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Tempat Lahir'),
                subtitle: Text("${biodata!.tempatlahir}"),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  logout();
                },
              ),
            ],
          )
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Guest',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Guest",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.pushNamed(context, '/login').then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          );
  }
}
