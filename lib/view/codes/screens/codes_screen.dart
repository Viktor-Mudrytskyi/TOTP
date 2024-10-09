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
                  return Dismissible(
                    key: ValueKey(value.seeds[index]),
                    onDismissed: (_) {
                      context.read<CodesProvider>().deleteSeed(seedData: value.seeds[index]);
                    },
                    confirmDismiss: (_) async {
                      final bool? response =
                          await showDialog<bool?>(context: context, builder: (context) => const DeleteDialog());
                      return response;
                    },
                    direction: DismissDirection.endToStart,
                    background: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    dismissThresholds: const {DismissDirection.endToStart: 0.4},
                    child: CodeTile(seedData: value.seeds[index]),
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
