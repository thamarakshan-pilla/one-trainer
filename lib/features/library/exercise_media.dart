import 'package:flutter/material.dart';

import '../../domain/exercise.dart';

/// Movement preview. Remote media is not loaded; this build stays on-device.
class ExerciseMedia extends StatelessWidget {
  const ExerciseMedia({required this.exercise, this.size, super.key});

  final Exercise exercise;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.fitness_center_rounded,
          size: size == null ? 42 : 26,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
    return Semantics(
      label: '${exercise.name} movement preview',
      image: true,
      child: SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: placeholder,
        ),
      ),
    );
  }
}
