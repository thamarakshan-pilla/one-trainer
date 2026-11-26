import '../domain/exercise.dart';
import '../domain/session_plan.dart';
import '../domain/workout_planner.dart';

/// This build has no planning service. The prompt stays hidden.
class OfflineWorkoutPlanner implements WorkoutPlanner {
  const OfflineWorkoutPlanner();

  @override
  bool get isConfigured => false;

  @override
  Future<SessionPlanQuery> interpret({
    required String request,
    required CatalogueVocabulary vocabulary,
  }) {
    throw const WorkoutPlannerException(
      'Session planning is not available offline.',
    );
  }

  @override
  Future<SessionPlan> select({
    required String request,
    required SessionPlanQuery query,
    required List<Exercise> candidates,
  }) {
    throw const WorkoutPlannerException(
      'Session planning is not available offline.',
    );
  }
}
