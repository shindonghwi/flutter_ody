import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/CardRecordItems.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/CardTodayRecord.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: getColorScheme(context).colorUI02,
                margin: EdgeInsets.only(top: CalendarSize.underMargin(context)),
                child: const CardTodayRecord(),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 40),
              sliver: CardRecordItems(),
            ),
            // const CardRecordItems(),
          ],
        ),
      ),
    );
  }
}
