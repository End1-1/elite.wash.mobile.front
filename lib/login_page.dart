import 'package:armpet_wash_mobile/app_page.dart';
import 'package:armpet_wash_mobile/utilities.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends AppPage {
  final GlobalKey<_PinCodeWidgetState> _pinKey = GlobalKey<_PinCodeWidgetState>();

  LoginPage({super.key});

  @override
  String pageTitle() => tr().login;

  @override
  Widget? actionBack(BuildContext context) => null;

  @override
  List<Widget> appBarActions(BuildContext context) => [
    IconButton(
      onPressed: () => Navigator.pushNamed(context, '/setup'),
      icon: Icon(Icons.settings),
    ),
  ];

  @override
  Widget body(BuildContext context) {
    return Column(
          children: [
            Expanded(
              child: Center(
                child: PinCodeWidget(
                  key: _pinKey,
                  onCompleted: (pin) => _onPinCompleted(context, pin),
                ),
              ),
            ),
          ],
        );

  }

  void _onPinCompleted(BuildContext context, String pin) async {
    showLoadingDialog();

    try {
      final Dio dio = Dio();
      final response = await dio.post(
          '${sp.string('base_url')}login/pin',
          data: {'pin': pin},
          options: Options(
            contentType: 'application/json',
            receiveTimeout: const Duration(seconds: 60),
          ));

      if (response.statusCode == 200) {
        hideDialog();
        final user = response.data['user'];
        sp.setString('f_token', user['f_token']);
        sp.setString('f_lastname', user['f_lastname']);
        sp.setString('f_firstname', user['f_firstname']);
        sp.setInt('f_user_id', user['f_id']);
        sp.setInt('f_group', user['f_group']);
        await Navigator.pushReplacementNamed(
          navigatorKey.currentContext!,
          '/',
          arguments: {'user': response.data['user']},
        );
      } else {
        _pinKey.currentState?.reset();
        hideDialog();
        showErrorDialog(response.data);
      }
    } on DioException catch (e) {
      _pinKey.currentState?.reset();
      hideDialog();
      showErrorDialog(e.response?.data ?? e.response?.statusMessage ?? e.toString());
    } catch (e) {
      _pinKey.currentState?.reset();
      hideDialog();
      showErrorDialog( e.toString());
    }
  }
}

class PinCodeWidget extends StatefulWidget {
  final int length;
  final void Function(String) onCompleted;

  const PinCodeWidget({super.key, this.length = 4, required this.onCompleted});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  String _pin = '';

  void _addDigit(String digit) {
    if (_pin.length < widget.length) {
      setState(() {
        _pin += digit;
      });
      if (_pin.length == widget.length) {
        //widget.onCompleted(_pin);
      }
    }
  }

  void reset() {
    setState(() {
      _pin = '';
    });
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _submit() {
    widget.onCompleted(_pin);
  }

  Widget _buildCircle(bool filled) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: filled ? Colors.indigoAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigoAccent, width: 2),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _addDigit(number),
          child: Text(
            number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.grey.shade300,
          ),
          onPressed: onPressed,
          child: Icon(icon, color: Colors.indigoAccent, size: 28),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.length,
            (index) => _buildCircle(index < _pin.length),
          ),
        ),
        const SizedBox(height: 24),

        Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                _buildActionButton(Icons.backspace, _removeDigit),
                _buildNumberButton('0'),
                _buildActionButton(Icons.check, _submit),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
