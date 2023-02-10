import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PackageInfo? packageInfo;

  String appName = "Not Set";

  @override
  void initState() {
    super.initState();
    getPackage();
  }

  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo!.packageName;
    });
    String packageName = packageInfo!.packageName;
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;
    print("App Name : ${appName}, App Package Name: ${packageName },App Version: ${version}, App build Number: ${buildNumber}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          appName,
          style: Theme.of(context).textTheme.displayLarge,
          maxLines: 2,
          softWrap: false,
        ),
      ),
    );
  }
}
