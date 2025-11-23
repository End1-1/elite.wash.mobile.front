import 'app_page.dart';
import 'dictionaries.dart';
import 'fr/car_model.dart';
import 'fr/goods.dart';
import 'utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fr/goods_group.dart';
import 'http_data.dart';

class SplashPage extends AppPage {
   const SplashPage({super.key});

  @override
  List<Widget> appBarActions(BuildContext context) {
    return [
      IconButton(onPressed: () => logout(context), icon: Icon(Icons.logout)),
    ];
  }

  @override
  Widget? actionBack(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return BlocProvider<HttpCubit>(
        create: (_) => HttpCubit(),
    child: _SplashContent());
  }
}

class _SplashContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashContentState();
}

class _SplashContentState extends State<_SplashContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HttpCubit>().post('init/get', postData: {'hall_id': sp.getInt('hall_id')});
    });
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HttpCubit, HttpData>(
        listener: (context, state) {
          if (state.state == HttpState.ok) {
            carSuggestions.clear();
            for (final j in state.data['cars']) {
              carSuggestions.add(CarModel.fromJson(j));
            }
            goodsGroups.clear();
            for (final j in state.data['groups'] ?? []) {
              goodsGroups.add(GoodsGroup.fromJson(j));
            }
            goods.clear();
            for (final j in state.data['dishes'] ?? []) {
              goods.add(Goods.fromJson(j));
            }
            sp.setInt('f_branch', state.data['branch']);
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state.state == HttpState.needsSetup) {
            Navigator.pushNamed(context, '/setup');
          } else if (state.state == HttpState.error) {
            showErrorDialog(state.data);
          } else {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.state == HttpState.loading) {}
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
    );
  }
}
