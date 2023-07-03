import 'package:flutter/material.dart';

class ReportWeeklyScreen extends StatelessWidget {
  final int? reportSeq;

  const ReportWeeklyScreen({
    Key? key,
    this.reportSeq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("ReportWeeklyScreen : reportSeq: $reportSeq"),
    );
  }
}
