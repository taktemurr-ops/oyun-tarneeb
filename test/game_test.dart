import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_tarneeb/oyun_tarneeb.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(tarneebConfig.title.length, 33);
    expect(tarneebConfig.tagline.length, 33);
    for (final s in tarneebConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler kazanılabilir ve el sonuna kadar oynanır', () {
    final planner = LevelPlanner(gameId: tarneebId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = tarneebRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final end = TrickGameRules.simulate(gl.puzzle);
      expect(end.phase, TrickPhase.over, reason: 'bölüm $lv');
    }
    expect(tarneebRules.localPlayers, 4);
  });
}
