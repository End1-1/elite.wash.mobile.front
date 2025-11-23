import 'package:armpet_wash_mobile/app_page.dart';
import 'package:armpet_wash_mobile/http_data.dart';
import 'package:armpet_wash_mobile/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dictionaries.dart';
import 'fr/car_model.dart';
import 'fr/goods.dart';

part 'order_page.car_autocomplete.dart';

class OrderPage extends AppPage {
  final int tableId;
  final GlobalKey<_OrderPageContentState> _contentStateKey =
      GlobalKey<_OrderPageContentState>();

  OrderPage({super.key, required this.tableId});

  @override
  String pageTitle() =>
      _contentStateKey.currentState?._tableName ?? tr().loading;

  @override
  Widget? actionBack(BuildContext context) => IconButton(
    onPressed: () => _contentStateKey.currentState?.back(),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  List<Widget> appBarActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => _contentStateKey.currentState?.save(),
        icon: Icon(Icons.save_as_outlined),
      ),
    ];
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _contentStateKey.currentState?.addGoods(),
      backgroundColor: Colors.blue,
      shape: CircleBorder(),
      child: Icon(Icons.add, size: 36),
    );
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider<HttpCubit>(
      create: (_) => HttpCubit(),
      child: _OrderPageContent(key: _contentStateKey, appPage: this),
    );
  }
}

class _OrderPageContent extends StatefulWidget {
  final OrderPage appPage;

  const _OrderPageContent({super.key, required this.appPage});

  @override
  State<StatefulWidget> createState() => _OrderPageContentState();
}

class _OrderPageContentState extends State<_OrderPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _carNumberController = TextEditingController();
  var _carModelId = 0;
  final _carModel = TextEditingController();
  final _customerController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  var _customerId = 0;
  final _carModelFocus = FocusNode();
  var _tableName = tr().loading;
  var _orderHeader = <String, dynamic>{};
  var _car = <String, dynamic>{};
  final _orderBody = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HttpCubit, HttpData>(
      listener: (context, state) {
        if (state.state == HttpState.ok) {
          if (state.data['action'] == 'searchcustomer') {
            if (state.data['error'].toString().isNotEmpty) {
              showErrorDialog(state.data['error']);
            }
            if (state.data['cars'].isNotEmpty) {
              final car = state.data['cars'];
              _carModel.text = car['f_model'];
              _customerController.text = car['f_name'];
              _phoneNumberController.text = car['f_info'];
              _customerId = car['f_id'];
              _carModelId = carSuggestions.firstWhere((e) => e.f_model == car['f_model'], orElse: () => CarModel(f_id: 0, f_model: '')).f_id;
            }
          }
          if (state.data['action'] == 'open') {
            _tableName = state.data['table_name'];
            _orderHeader =
                state.data['order']?['header'] ??
                {
                  'f_id': 0,
                  'f_table': widget.appPage.tableId,
                  'f_branch': sp.getInt('f_branch'),
                  'f_staff': sp.getInt('f_user_id'),
                  'f_hall': sp.getInt('hall_id'),
                  'f_servicevalue': 0,
                };
            _car = state.data['order']?['car'] ?? {
              'f_model_id':0,
              'f_model_name':'',
              'f_name':'',
              'f_govnumber':'',
              'f_info':'',
              'f_id': 0
            };
            _customerId = _car['f_id'];
            _orderBody.clear();
            _orderBody.addAll(state.data['order']?['dishes']??[]);
            _customerController.text = _car['f_name'];
            _phoneNumberController.text = _car['f_info'];
            _carNumberController.text = _car['f_govnumber'];
            _carModel.text = _car['f_model_name'];
            _carModelId = _car['f_model_id'];

            AppPageState.ofTitle(context)?.value = _tableName;
          }
        }
      },
      builder: (context, state) {
        if (state.state == HttpState.error) {
          return Column(
            children: [
              Row(children: [Expanded(child: Text(state.data))]),
            ],
          );
        }
        if (state.state == HttpState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.data['action'] == 'unlock') {
          return Text(tr().exiting);
        }

        return Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  textFormField(_carNumberController, tr().govNumber),
                  IconButton(
                    onPressed: () => _searchByGovNumber(context),
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: carModelAutocomplete(_carModel, _carModelFocus, (id) => _carModelId = id),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  textFormField(_customerController, tr().customer),
                  IconButton(
                    onPressed: () => _customerController.text = tr().unknown,
                    icon: Icon(Icons.question_mark),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  textFormField(_phoneNumberController, tr().phoneNumber),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(tr().orderNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(_orderHeader['f_id'].toString() ?? '0', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ]),
              for (final d in _orderBody) ...[
                Row(children: [
                  Text(d['f_dishname'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Expanded(child: Container()),
                  Text(sp.df(d['f_qty'].toString()), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ],)
              ]
            ],
          ),
        );
      },
    );
  }

  void save() {
    if (_orderHeader['f_id'] == 0) {
      return;
    }
    context.read<HttpCubit>().post(
      'tables/saveorder',
      postData: {
        'header': _orderHeader,
        'dishes': _orderBody,
        'car': {
          'f_model': _carModelId,
          'f_govnumber': _carNumberController.text,
        },
        'customer': {
          'f_name': _customerController.text,
          'f_info': _phoneNumberController.text,
          'f_id': _customerId,
        },
      },
    );
  }

  void addGoods() {
    var error = '';
    if (_carModel.text.isEmpty) {
      error += tr().carModelIsEmpty;
      error += '\r\n';
    } else if (!carSuggestions.any((car) => car.f_model == _carModel.text)) {
      error += tr().carModelIsEmpty;
      error += '\r\n';
    }
    if (_carNumberController.text.isEmpty) {
      error += tr().carNumberIsEmpty;
      error += '\r\n';
    }
    if (_customerController.text.isEmpty) {
      error += tr().customerNameIsEmpty;
      error += '\r\n';
    }
    if (error.isNotEmpty) {
      showErrorDialog(error);
      return;
    }
    Navigator.pushNamed<Goods?>(context, '/goods').then((v) {
      if (v != null) {
        if (v.f_store < 1) {
          showErrorDialog('Store id < 1, ${v.f_store}');
          return;
        }
        _orderBody.add(<String, dynamic>{
          'f_id':0,
          'f_state': 1,
          'f_dish': v.f_id,
          'f_dishname': v.f_en,
          'f_price': v.f_price,
          'f_store': v.f_store,
          'f_print': 1,
          'f_qty':1,
          'f_qtyprint': 1,
          'f_total': v.f_price,
          'f_row': _orderBody.length,
          'f_emark': null,
        });
        context.read<HttpCubit>().post(
          'tables/saveorder',
          postData: {
            'header': _orderHeader,
            'dishes': _orderBody,
            'car': {
              'f_model': _carModelId,
              'f_govnumber': _carNumberController.text,
            },
            'customer': {
              'f_name': _customerController.text,
              'f_info': _phoneNumberController.text,
              'f_id': _customerId,
            },
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HttpCubit>().post(
        'tables/open',
        postData: {'table_id': widget.appPage.tableId},
      );
    });
  }

  @override
  void dispose() {
    _carNumberController.dispose();
    _carModel.dispose();
    _customerController.dispose();
    _phoneNumberController.dispose();
    _carModelFocus.dispose();
    super.dispose();
  }

  void _searchByGovNumber(BuildContext context) {
    if (_carNumberController.text.isEmpty) {
      return;
    }
    context.read<HttpCubit>().post(
      'tables/searchcustomer',
      postData: {'search': _carNumberController.text},
    );
  }

  void back() async {
    await context.read<HttpCubit>().post(
      'tables/unlock',
      postData: {'table_id': widget.appPage.tableId},
    );
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
