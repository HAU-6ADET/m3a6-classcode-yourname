// Module 3 – Activity 6 – Monster Battler (the app "engine")
//
// This is the CODE behind a game - no screens yet. In Module 4 you will build a
// Flutter app on top of THIS exact file: a list of monsters, HP bars, and an
// "Attack" button that calls battle.attack(). Write it cleanly here and the UI
// later becomes easy.
//
// The type triangle (rock-paper-scissors):  fire 🔥 beats grass 🌿,
// grass 🌿 beats water 💧, water 💧 beats fire 🔥.
//
// You will build:
//   - a base `Monster` with shared data + behaviour,
//   - three species (`FireMon`, `WaterMon`, `GrassMon`) that each know their
//     own type matchups (polymorphism),
//   - a `Battle` engine that runs a turn-based duel.
//
// Concepts to research (see the Module 3 OOP cheat sheet:
// content/cheat-sheets/dart-m3-oop.md): abstract classes, `extends`/`super`,
// `@override`, polymorphism, getters, encapsulation with a private (`_`) field,
// and enums.
//
// The skeleton compiles. Fill in every TODO; do not rename the public members
// (the Flutter app and the tests rely on them).

/// The three elemental types. fire > grass > water > fire.
enum Element { fire, water, grass }

/// A creature that can battle. This is the BLUEPRINT shared by every species.
abstract class Monster {
  final String name;
  final int power; // base attack strength
  final int maxHp;
  int _hp; // current HP - changes only through takeDamage()

  Monster(this.name, this.power, this.maxHp) : _hp = maxHp;

  /// This monster's elemental type. Each species declares its own.
  Element get element;

  /// Current hit points (read-only from outside the class).
  int get hp => _hp;

  /// True once HP has reached 0.
  bool get isFainted => _hp <= 0;

  /// Type-effectiveness multiplier when THIS monster attacks [defender]:
  /// 2.0 if strong against it, 0.5 if weak against it, 1.0 otherwise.
  /// Each species overrides this with its own matchups.
  double bonusVs(Monster defender);

  /// Damage this monster deals to [defender] = power x type bonus.
  /// Notice this base method calls bonusVs(), which runs the SUBCLASS's
  /// version - that is polymorphism in action.
  int damageTo(Monster defender) => (power * bonusVs(defender)).round();

  /// Lower HP by [amount], but never below 0.
  void takeDamage(int amount) {
    // TODO: subtract `amount` from _hp; clamp it so it never goes below 0.
  }
}

class FireMon extends Monster {
  FireMon(String name, int power, int maxHp) : super(name, power, maxHp);

  @override
  Element get element => Element.fire;

  @override
  double bonusVs(Monster defender) {
    // TODO: Fire is strong (2.0) against Grass, weak (0.5) against Water,
    // and neutral (1.0) against anything else. Check defender.element.
    return 1.0;
  }
}

class WaterMon extends Monster {
  WaterMon(String name, int power, int maxHp) : super(name, power, maxHp);

  @override
  Element get element => Element.water;

  @override
  double bonusVs(Monster defender) {
    // TODO: Water is strong against Fire, weak against Grass, else neutral.
    return 1.0;
  }
}

class GrassMon extends Monster {
  GrassMon(String name, int power, int maxHp) : super(name, power, maxHp);

  @override
  Element get element => Element.grass;

  @override
  double bonusVs(Monster defender) {
    // TODO: Grass is strong against Water, weak against Fire, else neutral.
    return 1.0;
  }
}

/// The battle "engine": runs a turn-based duel between two monsters.
class Battle {
  final Monster a;
  final Monster b;

  /// A running history of what happened, one line per turn (handy for the UI).
  final List<String> log = [];

  bool _aTurn = true; // monster `a` attacks first

  Battle(this.a, this.b);

  /// True once either monster has fainted.
  bool get isOver => a.isFainted || b.isFainted;

  /// The monster left standing, or null if the battle is not over yet.
  Monster? get winner {
    // TODO: if the battle is over, return whichever monster is NOT fainted;
    // otherwise return null.
    return null;
  }

  /// Play ONE turn: the monster whose turn it is attacks the other once.
  void attack() {
    // TODO:
    //  1. if the battle isOver, just return (nothing to do).
    //  2. pick the attacker and defender based on _aTurn.
    //  3. final dmg = attacker.damageTo(defender);
    //     defender.takeDamage(dmg);
    //  4. add a line to `log`, e.g. '<attacker.name> hits <defender.name> for <dmg>'.
    //  5. flip _aTurn so the other monster goes next turn.
  }
}
