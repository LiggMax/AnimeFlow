import 'package:anime_flow/models/hot_item.dart';
import 'package:flutter/material.dart';

class IntroduceView extends StatefulWidget {
  final Subject subject;

  const IntroduceView(this.subject, {super.key});

  @override
  State<IntroduceView> createState() => _IntroduceViewState();
}

class _IntroduceViewState extends State<IntroduceView> {
  late final Subject subjectDetail = widget.subject;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subjectDetail.nameCN ?? subjectDetail.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(
                subjectDetail.info,
              ),
            ],
          ),
        ));
  }
}
