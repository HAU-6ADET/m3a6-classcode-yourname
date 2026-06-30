# Rubric - m3a6 Monster Battler (20 points)

Worth 20 points: an automated half (tests) and a code-quality half. Submit a
screenshot of your running battle (as in previous activities) as proof it runs.

## Automated checks (7 pts, scored from `dart test`)

| Check | Points |
| --- | --- |
| The behaviour/structure tests pass: Monster HP & fainting, the type chart (`bonusVs` 2.0 / 0.5 / 1.0), `damageTo` applying the type bonus (polymorphism), and a `Battle` that resolves to the correct winner | 7 |

(`student.json` must also be filled in.)

## Code quality (13 pts, judged from your code)

| Criterion | Max | Excellent | Needs work |
| --- | --- | --- | --- |
| Demonstrates understanding of the concepts | 5 | OOP modelling, inheritance/polymorphism, and the type system are used purposefully and correctly - not just enough to pass the tests | concepts applied superficially or copy-pasted; design choices do not make sense |
| Implements `HAUDEX.md` in the repo | 3 | present and complete per the brief | missing or token |
| Code structured well | 5 | readable, well-named, clean file/directory organisation, no dead code | monolithic or messy |

Code-quality total: 13 points.

**Automated 7 + code quality 13 = 20 total.**

Notes for feedback: name the concept to revisit or ask a guiding question; never
hand over corrected code. Judge genuine understanding and structure from the
code itself.
