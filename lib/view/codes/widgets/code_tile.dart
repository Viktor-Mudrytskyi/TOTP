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
        return const CodeTileBody();
      },
    );
  }
}

class CodeTileBody extends StatelessWidget {
  const CodeTileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleCodeProvider>(
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.codeModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _formatCode(
                        value.codeModel.code,
                      ),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFeatures: [
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: ClockIndicator(
                  progress: value.clockFraction,
                  progressColor: Theme.of(context).scaffoldBackgroundColor,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatCode(String code) {
    if (code.length != 6) {
      return code;
    }
    return '${code.substring(0, 3)} ${code.substring(3, 6)}';
  }
}
