import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/provider/MedicineListProvider.dart';
import 'package:odac_flutter_app/presentation/features/list/medication/widget/MedicineItem.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/utils/CollectionUtil.dart';

class MedicineMainContent extends HookConsumerWidget {
  final List<ResponseMeMedicineModel> items;

  const MedicineMainContent({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmItemsRead = ref.read(medicineListProvider.notifier);
    return CollectionUtil.isNullorEmpty(items)
        ? Center(
            child: EmptyView(
              screen: RoutingScreen.MedicationList,
              onPressed: () async {
                ResponseMeMedicineModel data = await Navigator.push(
                  context,
                  nextSlideScreen(RoutingScreen.AddMedication.route),
                );

                if (data.medicineSeq != null) {
                  alarmItemsRead.addMedicine(data);
                }
              },
            ),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16); // Adjust the height as needed
                },
                itemBuilder: (BuildContext context, int index) {
                  return MedicineItem(data: items[index]);
                },
                itemCount: items.length,
              ),
            ),
          );
  }
}
