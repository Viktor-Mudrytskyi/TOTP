import 'dart:math';

import 'package:flutter/material.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/view.dart';

class AddSeedDialog extends StatefulWidget {
  const AddSeedDialog({super.key, required this.onAdd, this.seed});
  final void Function(SeedData seed) onAdd;
  final String? seed;

  @override
  State<AddSeedDialog> createState() => _AddSeedDialogState();
}

class _AddSeedDialogState extends State<AddSeedDialog> {
  final _title = TitleValidatable('');
  final _seed = SeedValidatable('');

  @override
  void initState() {
    if (widget.seed != null) {
      _seed.update(widget.seed!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusArea(
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: min(MediaQuery.sizeOf(context).width, 250),
            height: min(MediaQuery.sizeOf(context).height, 340),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add title'),
                AppTextField(
                  hintText: 'Title',
                  onChanged: (val) {
                    _title.update(val);
                    setState(() {});
                  },
                  errorText: _title.failure?.message,
                ),
                const SizedBox(height: 20),
                const Text('Add seed'),
                AppTextField(
                  hintText: 'Seed',
                  onChanged: (val) {
                    _seed.update(val);
                    setState(() {});
                  },
                  errorText: _seed.failure?.message,
                  initialValue: _seed.value,
                ),
                const SizedBox(height: 20),
                AppPrimaryButton(
                  style: PrimaryButtonStyle.blue,
                  isEnabled: _title.isValid && _seed.isValid,
                  buttonText: 'Add',
                  onPressed: () {
                    widget.onAdd(SeedData(base32Seed: _seed.value, title: _title.value));
                    Navigator.of(context).maybePop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
