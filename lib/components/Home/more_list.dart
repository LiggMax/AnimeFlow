import 'package:flutter/material.dart';

class MoreList extends StatefulWidget {
  final int index;

  const MoreList({super.key, required this.index});

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
      child: Text(
        "商品${widget.index + 1}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }
}
