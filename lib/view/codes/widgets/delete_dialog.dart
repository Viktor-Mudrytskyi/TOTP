import 'dart:math';

import 'package:flutter/material.dart';
import 'package:totp_authenticator/view/view.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusArea(
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: min(MediaQuery.sizeOf(context).width, 250),
            height: min(MediaQuery.sizeOf(context).height, 180),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Are you sure you want to delete this seed?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                AppPrimaryButton(
                  buttonText: 'Delete',
                  style: PrimaryButtonStyle.red,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
