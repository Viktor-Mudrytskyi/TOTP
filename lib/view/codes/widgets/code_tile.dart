import 'package:flutter/widgets.dart';
import 'package:totp_authenticator/view/view.dart';

class CodeTile extends StatefulWidget {
  const CodeTile({super.key, required this.model});
  final CodeModel model;

  @override
  State<CodeTile> createState() => _CodeTileState();
}

class _CodeTileState extends State<CodeTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.model.refreshRate);
    _controller.value = widget.model.initialFractionValue;
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
              children: [
                Text(
                  widget.model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(widget.model.code),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
