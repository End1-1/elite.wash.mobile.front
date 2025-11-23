import 'package:armpet_wash_mobile/utilities.dart';
import 'package:flutter/material.dart';

import 'app_page.dart';

class SetupPage extends AppPage {
  final GlobalKey<_SetupPageContentState> _setupKey =
      GlobalKey<_SetupPageContentState>();

  SetupPage({super.key});

  @override
  String pageTitle() => tr().setup;

  @override
  Widget body(BuildContext context) {
    return _SetupPageContent(key: _setupKey);
  }

  @override
  List<Widget> appBarActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => _setupKey.currentState?.save(context),
        icon: Icon(Icons.save),
      ),
    ];
  }
}

class _SetupPageContent extends StatefulWidget {
  const _SetupPageContent({super.key});

  @override
  State<StatefulWidget> createState() => _SetupPageContentState();
}

class _SetupPageContentState extends State<_SetupPageContent> {
  final _serverAddressController = TextEditingController();
  final _settingsPasswordController = TextEditingController();
  final _hallIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _serverAddressController.text = sp.string('base_url');
    _settingsPasswordController.text = sp.string('settings_password');
    _hallIdController.text = sp.getInt('hall_id').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _serverAddressController,
                decoration: InputDecoration(
                  labelText: tr().serverUrl,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _settingsPasswordController,
                decoration: InputDecoration(
                  labelText: tr().settingsPassword,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(children: [
         Expanded(child: TextFormField(
           controller: _hallIdController,
           decoration: InputDecoration(
             labelText: tr().hallId,
             border: OutlineInputBorder(
               borderSide: BorderSide(color: Colors.black26),
             ),
           ),
         ))
        ])
      ],
    );
  }

  void save(BuildContext context) {
    if (!_serverAddressController.text.endsWith('/')) {
      _serverAddressController.text += '/';
    }
    sp.setString('base_url', _serverAddressController.text);
    sp.setString('settings_password', _settingsPasswordController.text);
    sp.setInt('hall_id', int.tryParse(_hallIdController.text) ?? 0);
    Navigator.pushNamed(context, '/');
  }
}
