import 'dart:io';

Future<void> main() async {
  final runNumber = 100;
  for (int i = 1; i <= runNumber; i++) {
    print('Run #$i');

    final result = await Process.run('flutter', ['test']);

    if (result.exitCode != 0) {
      print('Test failed on run #$i');
      print(result.stdout);
      print(result.stderr);
      exit(result.exitCode); // Stop the loop if a test fails
    }

    print(result.stdout);
  }
}
