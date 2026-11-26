import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trainerone/app/trainerone_app.dart';
import 'package:trainerone/core/notifications/rest_notification_service.dart';
import 'package:trainerone/core/database/app_database.dart';
import 'package:trainerone/data/demo_exercise_repository.dart';
import 'package:trainerone/data/local_exercise_repository.dart';
import 'package:trainerone/data/memory_workout_repository.dart';
import 'package:trainerone/data/sqlite_app_preferences_repository.dart';
import 'package:trainerone/data/sqlite_body_weight_repository.dart';
import 'package:trainerone/data/sqlite_exercise_store.dart';
import 'package:trainerone/data/sqlite_muscle_coverage_repository.dart';
import 'package:trainerone/data/sqlite_training_analytics_repository.dart';
import 'package:trainerone/data/sqlite_workout_repository.dart';
import 'package:trainerone/domain/app_preferences.dart';
import 'package:trainerone/domain/body_weight.dart';
import 'package:trainerone/domain/exercise_repository.dart';
import 'package:trainerone/domain/muscle_map.dart';
import 'package:trainerone/domain/training_analytics.dart';
import 'package:trainerone/domain/workout_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RestNotificationService.initialize();

  ExerciseRepository exerciseRepository = DemoExerciseRepository();
  WorkoutRepository workoutRepository = MemoryWorkoutRepository();
  TrainingAnalyticsRepository? analyticsRepository;
  BodyWeightRepository? bodyWeightRepository;
  MuscleCoverageRepository? muscleCoverageRepository;
  AppPreferencesRepository? appPreferences;

  if (!kIsWeb) {
    try {
      final database = AppDatabase.open();
      workoutRepository = SqliteWorkoutRepository(database);
      // Aggregates in SQL rather than loading a training history into memory
      // to sum it, so cost stays flat as the history grows.
      analyticsRepository = SqliteTrainingAnalyticsRepository(database);
      bodyWeightRepository = SqliteBodyWeightRepository(database);
      muscleCoverageRepository = SqliteMuscleCoverageRepository(database);
      appPreferences = SqliteAppPreferencesRepository(database);
      exerciseRepository = LocalExerciseRepository(
        SqliteExerciseStore(database),
      );
    } catch (error, stackTrace) {
      debugPrint('Startup fallback activated: $error\n$stackTrace');
    }
  }

  runApp(
    TrainerOneApp(
      exerciseRepository: exerciseRepository,
      workoutRepository: workoutRepository,
      analyticsRepository: analyticsRepository,
      bodyWeightRepository: bodyWeightRepository,
      muscleCoverageRepository: muscleCoverageRepository,
      appPreferences: appPreferences,
    ),
  );
}
