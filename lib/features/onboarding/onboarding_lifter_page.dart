import 'package:flutter/material.dart';

import '../../core/motion/repset_motion.dart';
import 'onboarding_flow.dart';

/// The lifter path: the logger is free and stays on the device.
class OnboardingLifterPage extends StatelessWidget {
  const OnboardingLifterPage({
    super.key,
    required this.name,
    required this.onContinue,
  });

  final String name;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final greeting = name.isEmpty ? 'Great.' : 'Great, $name.';
    return OnboardingScaffold(
      footer: OnboardingButton(
        key: const Key('onboarding-lifter-continue'),
        label: 'Start training',
        icon: Icons.arrow_forward_rounded,
        onPressed: onContinue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RepSetEntrance(
            child: Text(
              greeting,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                height: 1.06,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          RepSetEntrance(
            delay: const Duration(milliseconds: 60),
            child: Text(
              'TrainerOne is a free training logger. Log your sessions — all of it '
              'stays on this device, with no account.',
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 14.5,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 26),
          for (final (index, item) in const [
            (Icons.check_rounded, 'Every workout, set and rep'),
            (Icons.check_rounded, 'Templates and training history'),
            (Icons.check_rounded, 'Progress and muscle coverage'),
            (Icons.check_rounded, 'Yours on your device, always free'),
          ].indexed) ...[
            RepSetEntrance(
              delay: Duration(milliseconds: 100 + index * 35),
              child: _FreeRow(icon: item.$1, label: item.$2),
            ),
            const SizedBox(height: 9),
          ],
        ],
      ),
    );
  }
}

class _FreeRow extends StatelessWidget {
  const _FreeRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: onboardingAccent.withValues(alpha: .16),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 13, color: onboardingAccent),
      ),
      const SizedBox(width: 11),
      Expanded(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: -.15,
          ),
        ),
      ),
    ],
  );
}
