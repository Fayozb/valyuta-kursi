import 'package:flutter/material.dart';

import 'currency.dart';

class ConverterPage extends StatefulWidget {
  final Currency currency;

  const ConverterPage({super.key, required this.currency});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currency.ccyNmUZ}'),
      ),
    );
  }
}
