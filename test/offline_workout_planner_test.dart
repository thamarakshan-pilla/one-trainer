import 'package:flutter_test/flutter_test.dart';
import 'package:trainerone/data/offline_workout_planner.dart';
import 'package:trainerone/domain/session_plan.dart';
import 'package:trainerone/domain/workout_planner.dart';

void main() {
  test('offline builds have no planning backend', () {
    final planner = const OfflineWorkoutPlanner();
    expect(planner.isConfigured, isFalse);
    expect(
      () => planner.interpret(
        request: 'push day',
        vocabulary: const CatalogueVocabulary(
          bodyParts: [],
          targets: [],
          equipment: [],
        ),
      ),
      throwsA(isA<WorkoutPlannerException>()),
    );
  });
}
