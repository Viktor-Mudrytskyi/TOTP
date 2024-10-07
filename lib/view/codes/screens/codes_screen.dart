import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/view.dart';

class CodesScreen extends StatelessWidget {
  const CodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<CodesProvider>()..init(),
      builder: (context, _) {
        final provider = context.read<CodesProvider>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Authentication codes'),
          ),
          body: Consumer<CodesProvider>(
            builder: (context, value, child) {
              if (value.isInitialLoad) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (value.seeds.isEmpty) {
                return const Center(
                  child: Text('No seeds yet...'),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  return CodeTile(
                    model: CodeModel(
                      title: value.seeds[index].title,
                      code: value.seeds[index].base32Seed,
                      refreshRate: const Duration(seconds: 30),
                      initialFractionValue: 0.1,
                      base32Seed: value.seeds[index].base32Seed,
                    ),
                  );
                },
                itemCount: value.seeds.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => AddSeedDialog(
                  onAdd: (seed) {
                    provider.addNewSeed(seedData: seed);
                  },
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
