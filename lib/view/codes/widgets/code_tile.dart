import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/view.dart';

class CodeTile extends StatelessWidget {
  const CodeTile({super.key, required this.seedData});
  final SeedData seedData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<SingleCodeProvider>()..init(seedData),
      builder: (context, _) {
        return Consumer<SingleCodeProvider>(
          builder: (context, value, child) {
            return CodeTileBody(
              model: value.codeModel,
            );
          },
        );
      },
    );
  }
}

class CodeTileBody extends StatefulWidget {
  const CodeTileBody({super.key, required this.model});
  final CodeModel model;

  @override
  State<CodeTileBody> createState() => _CodeTileBodyState();
}

class _CodeTileBodyState extends State<CodeTileBody> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.model.refreshRate)
      ..repeat()
      ..value = widget.model.initialFractionValue
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.model.code,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
