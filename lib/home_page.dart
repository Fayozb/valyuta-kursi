import 'package:converter/app_helpers.dart';

import 'currencyitem.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'currency.dart';
import 'http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime selectedDate;
  int page = 0;
  late RefreshController refreshController;
  bool _isLoading = false;
  List<Currency> _currencies = [];



  @override
  void initState() {
    super.initState();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async {
    setState(() {
      refreshController = RefreshController();
      selectedDate = DateTime.now();
      _isLoading = true;
      _currencies = [];
    });
    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get('/uz/arkhiv-kursov-valyut/json/all/');
    debugPrint('===> $response');
    setState(() {
      _isLoading = false;
      _currencies = CurrencyResponse.fromJson(response.data).data ?? [];
    });
    refreshController.loadComplete();
  }
  Future<void> refrefshvalyut() async {
    page = 0;
    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get('/uz/arkhiv-kursov-valyut/json/all/');
    setState(() {
      _currencies = CurrencyResponse.fromJson(response.data).data ?? [];
    });
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40,),
          OutlinedButton(onPressed: () {
              showDatePicker(context: context, initialDate: selectedDate, firstDate: (DateTime.now().subtract(Duration(days: 30))), lastDate: DateTime.now());
          }, child: Text(AppHelpers.getFormattedDate(selectedDate))),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SmartRefresher(
              controller: refreshController,
              onRefresh: refrefshvalyut,
              enablePullUp: true,
              child: ListView.builder(
                  itemCount: _currencies.length,
                  itemBuilder: (context, index) {
                    return CurrencyItem(currency: _currencies[index]);
                  }),
            ),
          ),
        ],
      )
    );
  }
}
