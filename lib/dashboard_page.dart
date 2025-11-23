import 'package:armpet_wash_mobile/http_data.dart';
import 'package:armpet_wash_mobile/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_page.dart';

class Dashboard extends AppPage {
  final GlobalKey<_DashboardContentState> _dashboardKey =
      GlobalKey<_DashboardContentState>();

  Dashboard({super.key});

  @override
  Widget? actionBack(BuildContext context) => null;

  @override
  String pageTitle() =>
      '${tr().dashboard} (${sp.string('f_lastname')} ${sp.string('f_firstname')})';

  @override
  List<Widget> appBarActions(BuildContext context) {
    return [
      IconButton(onPressed: () => _dashboardKey.currentState?.load(), icon: Icon(Icons.refresh)),
      IconButton(onPressed: () => logout(context), icon: Icon(Icons.logout)),
    ];
  }

  @override
  Future<void> appResumed(BuildContext context) async {
    _dashboardKey.currentState?.load();
  }

  @override
  Widget body(BuildContext context) {
    return BlocProvider<HttpCubit>(
      create: (_) => HttpCubit(),
      child: _DashboardContent(key: _dashboardKey, appPage: this),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  final AppPage appPage;

  const _DashboardContent({super.key, required this.appPage});

  @override
  State<StatefulWidget> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HttpCubit>().post(
        'tables/get',
        postData: {'hall_id': sp.getInt('hall_id')},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HttpCubit, HttpData>(
      builder: (context, state) {
        if (state.state == HttpState.ok) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      for (final e in state.data['tables'] ?? []) ...[
                        table(context, e),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state.state == HttpState.error) {
          return Center(child: Text(state.data));
        }
        return Center(child: CircularProgressIndicator());
      },
      listener: (context, state) {
        if (state.state == HttpState.loading) {
          AppPageState.ofTitle(context)?.value = tr().loading;
        } else if (state.state == HttpState.ok) {
          AppPageState.ofTitle(context)?.value =
              '${tr().dashboard} (${sp.string('f_lastname')} ${sp.string('f_firstname')})';
        }
      },
    );
  }

  Widget table(BuildContext context, dynamic td) {
    return InkWell(
      onTap: () => _tableTap(context, td['f_id']),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: td['f_order'] == 0 ? Colors.indigo : Colors.green,
        ),
        child: Column(
          children: [
            Text(td['f_name'], style: const TextStyle(color: Color(0xffFFD700  ), fontSize: 18, fontWeight: FontWeight.bold)),
            if (td['f_order'] > 0) ... [
              Text(td['f_govnumber'], style: const TextStyle(color: Color(0xffFFD700 ), fontSize: 18, fontWeight: FontWeight.bold)),
              Text(td['f_modelname'], maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,  style: const TextStyle(color: Color(0xffFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
              Text(sp.df(td['f_total'].toString()), maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,  style: const TextStyle(color: Color(0xffFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }

  void _tableTap(BuildContext context, int id) {
    Navigator.pushNamed(context, '/order', arguments: id).then((_) => load());
  }

  void load() {
    if (!mounted) {
      return;
    }
    context.read<HttpCubit>().post('tables/get', postData: {'hall_id': sp.getInt('hall_id')});
  }
}
