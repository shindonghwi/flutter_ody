import 'package:flutter/material.dart';

class ReportMonthlyScreen extends StatelessWidget {
  final int? reportSeq;

  const ReportMonthlyScreen({
    Key? key,
    this.reportSeq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("ReportMonthlyScreen : reportSeq: $reportSeq"),
    );
  }
}
