import 'package:flutter/material.dart';

class MoreList extends StatefulWidget {
  const MoreList({super.key});

  @override
  State<MoreList> createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const Text("商品",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
    );
  }
}
