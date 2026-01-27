import 'dart:async';

import 'package:flutter/material.dart';

class DebouncedButton extends StatefulWidget {
  final Widget _button;
  final VoidCallback _onPressed;
  final Duration _duration;
  final ShapeBorder _customBorder;

  DebouncedButton({
    super.key,
    required Widget button,
    required VoidCallback onPressed,
    int debounceTimeMs = 300,
    ShapeBorder? customBorder,
  })  : _button = button,
        _onPressed = onPressed,
        _duration = Duration(milliseconds: debounceTimeMs),
        _customBorder = customBorder ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

  @override
  _DebouncedButtonState createState() => _DebouncedButtonState();
}

class _DebouncedButtonState extends State<DebouncedButton> {
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _isEnabled = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isEnabled,
      builder: (context, isEnabled, child) => InkWell(
        customBorder: widget._customBorder,
        onTap: isEnabled ? _onButtonPressed : null,
        child: widget._button,
      ),
    );
  }

  void _onButtonPressed() {
    _isEnabled.value = false;
    widget._onPressed();
    _timer = Timer(widget._duration, () => _isEnabled.value = true);
  }
}
