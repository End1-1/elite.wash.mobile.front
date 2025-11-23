import 'package:armpet_wash_mobile/utilities.dart';
import 'package:flutter/material.dart';

abstract class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => AppPageState();

  String pageTitle() => 'Elite car wash';

  Widget body(BuildContext context);

  Widget? floatingActionButton() => null;

  Future<void> appResumed(BuildContext context) async {}

  List<Widget> appBarActions(BuildContext context) => [];

  Widget? actionBack(BuildContext context) => IconButton(
    onPressed: () => Navigator.pop(context),
    icon: const Icon(Icons.arrow_back),
  );

  void logout(BuildContext context) {
    showConfirmDialog(context, tr().areYouSureToLogout).then((reply) {
      if (reply) {
        sp.setString('f_token', '');
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          '/',
          (_) => false,
        );
      } else {}
    });
  }
}

class AppPageState extends State<AppPage> with WidgetsBindingObserver {
  late final ValueNotifier<String> titleNotifier;

  static ValueNotifier<String>? ofTitle(BuildContext context) {
    final state = context.findAncestorStateOfType<AppPageState>();
    return state?.titleNotifier;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    titleNotifier = ValueNotifier(widget.pageTitle());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.appResumed(context);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  void dispose() {
    titleNotifier.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder<String>(
          valueListenable: titleNotifier,
          builder:
              (context, title, _) => FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(title, overflow: TextOverflow.ellipsis),
              ),
        ),
        backgroundColor: Colors.indigoAccent,
        automaticallyImplyLeading: false,
        leading: widget.actionBack(context),
        actions: widget.appBarActions(context),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(5),
        child: widget.body(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.floatingActionButton(),
    );
  }
}
