# Module 3 – Activity 6 – Monster Battler (Dart)

[![Made with Claude](https://img.shields.io/badge/Made_with-Claude-D97757?logo=anthropic&logoColor=white)](https://tjakoen.github.io/notes/ten-times-zero)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)

The Module 3 finale: build the **engine of a game** in pure Dart. No screens
yet - just the data and logic. In **Module 4 (Flutter)** you will build a real
app on top of *this exact code*: a list of monsters, HP bars, and an **Attack**
button that calls `battle.attack()`. Write it cleanly here and the UI later is
the easy part.

## The game

Three elemental types beat each other in a cycle:

```
fire 🔥  beats  grass 🌿  beats  water 💧  beats  fire 🔥 ...
```

- **fire** beats **grass**
- **grass** beats **water**
- **water** beats **fire**

A "super effective" hit does **double** damage; a "not very effective" hit does
**half**. Everything else is normal.

## The classes

```
                ┌───────────────────────────────┐
                │      Monster  (abstract)       │
                ├───────────────────────────────┤
                │ name, power, maxHp             │
                │ - _hp        (private)         │
                ├───────────────────────────────┤
                │ hp, isFainted   (getters)      │
                │ damageTo(other) = power×bonus  │
                │ takeDamage(amount)             │
                │ element            (abstract)  │
                │ bonusVs(other)     (abstract)  │
                └───────────────────────────────┘
                  ▲           ▲           ▲
        ┌─────────┘     ┌─────┘     └─────────┐
   ┌──────────┐   ┌───────────┐   ┌───────────┐
   │ FireMon  │   │ WaterMon  │   │ GrassMon  │
   └──────────┘   └───────────┘   └───────────┘
   each overrides element + bonusVs (its own matchups)

   ┌──────────────────────────────────────────┐
   │ Battle  - the engine                       │
   │  attack()  · isOver · winner · log         │
   └──────────────────────────────────────────┘
```

## What to do

### 1. Fill in your details

Open `student.json` and fill in every field (use the **class code** your
instructor gave you):

```json
{
  "classCode": "1234",
  "fullName": "Juan Dela Cruz",
  "studentNumber": "2026-12345",
  "studentEmail": "juan.delacruz@hau.edu.ph",
  "personalEmail": "juan@example.com",
  "githubAccount": "juandelacruz"
}
```

> **Keep `student.json` identical across all your activities.** The autograder
> cross-checks these fields between your repos, and a mismatch (e.g. a different
> `classCode` in one activity) is flagged. The `classCode` must also match the
> one in your repo name.

### 2. Build the engine

The code lives in **[`lib/battler.dart`](lib/battler.dart)** (in `lib/`, so the
Flutter app in Module 4 can import it). Complete:

| Member | What it does |
| --- | --- |
| `Monster.takeDamage(amount)` | lower `_hp` by `amount`, never below 0 (encapsulation) |
| `FireMon` / `WaterMon` / `GrassMon` `.bonusVs(other)` | return `2.0` / `0.5` / `1.0` for that species' matchups (polymorphism) |
| `Battle.winner` | the monster still standing once the battle is over, else `null` |
| `Battle.attack()` | one turn: current attacker hits the other, defender takes damage, record it in `log`, pass the turn |

The base class already gives you `hp`, `isFainted`, `damageTo()` (which is
`power × bonusVs(...)`), and `isOver`. Each species' `element` is set for you -
your job is the matchup logic and the battle flow.

> **Concepts to research** - see the **Module 3 – OOP** cheat sheet in your
> workspace repo (`content/cheat-sheets/dart-m3-oop.md`): abstract classes,
> `extends`/`super`, `@override`, polymorphism, getters, a private `_` field,
> and enums.

Try your engine with the console demo:

```bash
dart run bin/main.dart
```

### 3. Looking ahead to Flutter (Module 4)

You do not build any UI here - but it helps to know where this is going. In the
final Flutter intro activity you will `import` this engine and wire it to a
screen:

| UI piece | Engine it reads/calls |
| --- | --- |
| monster cards | `monster.name`, `monster.element` |
| HP bars | `monster.hp` / `monster.maxHp` |
| **Attack button** | `battle.attack()` (then refresh the screen) |
| battle log list | `battle.log` |
| "You win!" banner | `battle.isOver`, `battle.winner` |

That is why the battle is **turn-based** (one tap = one `attack()`) and why
`hp`/`maxHp` are public: it makes the UI simple later.

## Set up your repo

Before you write any code, create **your own copy** of this activity from the
template. Do not work in the template itself.

1. **Create from the template.** Open the template repo and click
   **Use this template → Create a new repository**.
2. **Set the owner to the course org.** Under *Owner*, choose the **`HAU-6ADET`
   course org**, **not** your personal account.
3. **Name it by the convention** `m<module>a<activity>-<classcode>-<yourname>`.
   For this activity that's **`m3a6-<classcode>-yourname`** (e.g.
   `m3a6-1234-juandelacruz`). The `<classcode>` must match the one you put in
   `student.json`.
4. **Make it Private.** Set *Visibility* to **Private** so classmates can't see
   your work.

Then clone **your** new repo and work there:

```bash
git clone https://github.com/HAU-6ADET/m3a6-<classcode>-yourname.git
cd m3a6-<classcode>-yourname
```

## Running the tests

```bash
dart pub get
dart test
```

This activity is graded by **7 tests** (1 point each). They check:

- ✅ `student.json` is completely filled in (1 test)
- ✅ a monster starts at full HP and faints only at 0 (`takeDamage` clamps) (1 test)
- ✅ the type chart `bonusVs` gives 2.0 / 0.5 / 1.0 correctly (1 test)
- ✅ `damageTo` applies power × type bonus (1 test)
- ✅ one `attack()` damages only the defender and records the hit (1 test)
- ✅ a battle plays out to the correct winner (1 test)
- ✅ different species deal type-based damage to the same target (polymorphism) (1 test)

Each part is graded independently, so you earn partial credit.

## Confirm your submission

Your repo **is** your submission, so there is nothing to upload anywhere. When the
tests pass locally, **commit and push** so your work is recorded:

```bash
git add -A
git commit -m "Activity 6 complete"
git push
```

Pushing triggers the **Autograde** workflow. Confirm your submission landed:

1. Open your repo on GitHub and click the **Actions** tab.
2. Open the latest **Autograde** run and confirm the green ✅ check
   and the "7 / 7 tests passed" summary.

## 💻 Work in a Codespace (recommended)

A **Codespace** is a complete dev environment that runs in the cloud, so you do
not have to install Node, Dart, or anything else on your own laptop. This repo is
already configured: open a Codespace and everything you need is ready.

**Open one:** click the green **Code** button → **Codespaces** tab → **Create
codespace on main**. The first launch takes a minute to set up; after that it is
instant. Then run the activity from its terminal exactly as described below.

**Use it in VS Code (recommended).** It works in the browser, but it is nicer in
the desktop app: install the **GitHub Codespaces** extension in VS Code, or from
the running Codespace click the menu (☰) → **Open in VS Code Desktop**. Same
environment, your own editor.

### ⏱️ Make your free hours last (please read)
Your GitHub Education account includes a generous but limited monthly Codespaces
allowance. Three habits keep you from wasting it:

1. **Set your idle timeout to 10 minutes.** Go to
   **github.com/settings/codespaces → Default idle timeout → 10 minutes → Save.**
   A Codespace keeps running (and spending your hours) when you walk away; this
   makes it auto-stop after 10 idle minutes.
2. **Stop it when you finish - don't just close the tab.** Closing the browser
   leaves it running. Stop it at **github.com/codespaces → ••• → Stop
   codespace**, or from inside the editor open the **Command Palette**
   (`Ctrl`/`Cmd`+`Shift`+`P`, or **F1**) and run
   *Codespaces: Stop Current Codespace*.
3. **Delete the Codespace once you've submitted this activity.** Every activity
   gets its own Codespace, so old ones pile up and use your storage. After your
   final push: **github.com/codespaces → ••• → Delete.** You can always recreate
   it later from the green **Code** button.

---
📚 **These materials were authored by [tjakoen](https://github.com/tjakoen), built with Claude.** I use AI in the open, and I expect you to use it to learn the material, not to skip the learning. [How I actually work with AI →](https://tjakoen.github.io/notes/ten-times-zero)
