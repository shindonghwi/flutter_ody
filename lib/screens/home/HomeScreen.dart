import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          AppLocalizations.of(context).appTitle,
          style: Theme.of(context).textTheme.displayLarge,
          maxLines: 2,
          softWrap: false,
        ),
      ),
    );
  }
}
