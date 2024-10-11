import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends StatefulWidget {
  const ScanCodeScreen({super.key, required this.onScaned});
  final void Function(BarcodeCapture val) onScaned;

  @override
  State<ScanCodeScreen> createState() => _ScanCodeScreenState();
}

class _ScanCodeScreenState extends State<ScanCodeScreen> with WidgetsBindingObserver {
  late final MobileScannerController _controller;
  StreamSubscription<BarcodeCapture>? _codesSubscription;

  @override
  void initState() {
    _controller = MobileScannerController(formats: [BarcodeFormat.qrCode]);
    _codesSubscription = _controller.barcodes.listen(
      _listen,
    );
    super.initState();
  }

  Future<void> _listen(
    BarcodeCapture val,
  ) async {
    await _controller.stop();
    if (mounted) {
      Navigator.of(context).pop();
    }
    widget.onScaned(val);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _codesSubscription = _controller.barcodes.listen(_listen);

        unawaited(_controller.start());
      case AppLifecycleState.inactive:
        unawaited(_codesSubscription?.cancel());
        _codesSubscription = null;
        unawaited(_controller.stop());
    }
  }

  @override
  void dispose() {
    unawaited(_controller.dispose());
    unawaited(_codesSubscription?.cancel());
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constr) {
        final Size layoutSize = constr.biggest;

        final double scanWindowWidth = layoutSize.width / 1.8;
        final double scanWindowHeight = layoutSize.height / 1.8;

        final decidedSide = min(scanWindowHeight, scanWindowWidth);
        final center = layoutSize.center(Offset.zero);

        final Rect scanWindow = Rect.fromCenter(
          center: center,
          width: decidedSide,
          height: decidedSide,
        );
        return MobileScanner(
          controller: _controller,
          scanWindow: scanWindow,
          overlayBuilder: (context, constr2) {
            return SizedBox(
              width: layoutSize.width,
              height: layoutSize.height,
              child: CustomPaint(
                painter: RectanglePainter(
                  rect: scanWindow,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RectanglePainter extends CustomPainter {
  const RectanglePainter({super.repaint, required this.rect});

  final Rect rect;
  @override
  void paint(Canvas canvas, Size size) {
    // Create a paint object with the desired color and style
    final paint = Paint()
      ..color = Colors.white // Rectangle color
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke; // Choose fill or stroke

    // Draw the rectangle on the canvas
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
