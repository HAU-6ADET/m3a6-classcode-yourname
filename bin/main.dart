// A tiny console demo of your engine. Once you have filled in lib/battler.dart,
// run it with:  dart run bin/main.dart
//
// In Module 4 this same engine gets a Flutter screen instead of print().

import 'package:m3a6_battler/battler.dart';

void main() {
  final blaze = FireMon('Blaze', 12, 40);
  final ripple = WaterMon('Ripple', 10, 40);

  print('A wild battle begins: ${blaze.name} vs ${ripple.name}!\n');

  final battle = Battle(blaze, ripple);

  // One tap of an "Attack" button = one call to battle.attack().
  var guard = 0; // safety stop in case the engine is not finished yet
  while (!battle.isOver && guard < 100) {
    battle.attack();
    guard++;
  }

  for (final line in battle.log) {
    print(line);
  }
  print('\nWinner: ${battle.winner?.name ?? "nobody yet - finish the engine!"}');
}
