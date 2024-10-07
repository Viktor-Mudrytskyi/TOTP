import 'package:flutter/material.dart';
import 'package:totp_authenticator/core/core.dart';

class UnfocusArea extends StatelessWidget {
  const UnfocusArea({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: context.removeFocus,
        child: child,
      );
}
