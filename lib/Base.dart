import 'package:flutter/material.dart';

class BaseViewModel<T extends BaseNavigetor> extends ChangeNotifier {
  late T navigetor;
}

abstract class BaseNavigetor {
  void showMassage(String masssage);

  void showLoading({bool IsDissmassable});

  void hidMassage();
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigetor {
  late VM viewModel;

  VM iniViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = iniViewModel();
  }

  @override
  void hidMassage() {
    Navigator.pop(context);
  }

  @override
  void showLoading({bool IsDissmassable = true}) {
    showDialog(
        barrierDismissible: IsDissmassable,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  void showMassage(s) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(s),
          );
        });
  }
}
