import 'package:flutter_test/flutter_test.dart';
import 'package:trainerone/core/database/app_database.dart';
import 'package:trainerone/data/local_exercise_repository.dart';
import 'package:trainerone/data/sqlite_exercise_store.dart';
import 'package:trainerone/domain/exercise.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('seeds demos once and retains a custom exercise locally', () async {
    final database = AppDatabase.open(path: inMemoryDatabasePath);
    final repository = LocalExerciseRepository(SqliteExerciseStore(database));
    final seeded = await repository.refresh('en');
    expect(seeded, isNotEmpty);

    const custom = Exercise(
      id: 'custom-odd-machine',
      name: 'Odd machine press',
      bodyPart: 'Custom',
      target: 'Chest',
      equipment: 'Plate-loaded machine',
      secondaryMuscles: [],
      instructions: [],
      isCustom: true,
    );
    await repository.saveCustom('en', custom);

    final restored = await repository.refresh('en');
    expect(restored.map((exercise) => exercise.id), contains(custom.id));
    await (await database).close();
  });
}
