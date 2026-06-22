import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'package:m3a6_battler/battler.dart';

void main() {
  test('student.json is filled in', () {
    final info = jsonDecode(File('student.json').readAsStringSync())
        as Map<String, dynamic>;
    for (final field in [
      'classCode',
      'fullName',
      'studentNumber',
      'studentEmail',
      'personalEmail',
      'githubAccount',
    ]) {
      expect(info[field], isNotEmpty, reason: 'Set "$field" in student.json');
    }
  });

  group('Monster', () {
    test('starts at full HP and faints only when HP reaches 0', () {
      final m = FireMon('Ember', 12, 40);
      expect(m.hp, 40);
      expect(m.isFainted, isFalse);
      m.takeDamage(15);
      expect(m.hp, 25);
      m.takeDamage(1000);
      expect(m.hp, 0, reason: 'HP must never drop below 0');
      expect(m.isFainted, isTrue);
    });

    test('type chart: bonusVs is 2.0 (strong) / 0.5 (weak) / 1.0 (neutral)', () {
      final fire = FireMon('F', 10, 10);
      final water = WaterMon('W', 10, 10);
      final grass = GrassMon('G', 10, 10);
      expect(fire.bonusVs(grass), 2.0);
      expect(fire.bonusVs(water), 0.5);
      expect(fire.bonusVs(FireMon('F2', 10, 10)), 1.0);
      expect(water.bonusVs(fire), 2.0);
      expect(water.bonusVs(grass), 0.5);
      expect(grass.bonusVs(water), 2.0);
      expect(grass.bonusVs(fire), 0.5);
    });

    test('damageTo applies power x type bonus (polymorphism)', () {
      final fire = FireMon('F', 12, 40);
      expect(fire.damageTo(GrassMon('G', 10, 40)), 24); // 12 * 2.0
      expect(fire.damageTo(WaterMon('W', 10, 40)), 6); //  12 * 0.5
      expect(fire.damageTo(FireMon('F2', 10, 40)), 12); // 12 * 1.0
    });
  });

  group('Battle', () {
    test('one attack damages only the defender and records the hit', () {
      final fire = FireMon('F', 12, 40);
      final water = WaterMon('W', 10, 40);
      final battle = Battle(fire, water);
      battle.attack(); // fire hits water for 12 * 0.5 = 6
      expect(water.hp, 34);
      expect(fire.hp, 40, reason: 'only the defender takes damage on a turn');
      expect(battle.log.length, 1);
    });

    test('plays out to the correct winner', () {
      final fire = FireMon('F', 12, 40);
      final grass = GrassMon('G', 10, 40);
      final battle = Battle(fire, grass);
      var guard = 0;
      while (!battle.isOver && guard < 100) {
        battle.attack();
        guard++;
      }
      expect(battle.isOver, isTrue);
      expect(grass.isFainted, isTrue);
      expect(battle.winner, same(fire));
    });
  });

  group('Polymorphism', () {
    test('different species deal type-based damage to the same target', () {
      final target = WaterMon('Target', 10, 100);
      final List<Monster> attackers = [
        FireMon('F', 10, 40), //  weak vs water  -> 10 * 0.5 = 5
        GrassMon('G', 10, 40), // strong vs water -> 10 * 2.0 = 20
        WaterMon('W', 10, 40), // neutral         -> 10 * 1.0 = 10
      ];
      final dmg = attackers.map((m) => m.damageTo(target)).toList();
      expect(dmg, [5, 20, 10]);
    });
  });
}
