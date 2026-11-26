import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../dev/animation_lab_page.dart';

/// The app's settings surface.
///
/// Also the home of developer tools, which used to sit in the navigation dock.
/// A debug-only surface does not deserve a permanent seat next to the tabs
/// people use every day.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
          children: [
            Text(
              'SETTINGS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            const _SectionLabel('App'),
            const SizedBox(height: 10),
            const _SettingsTile(
              icon: Icons.notifications_none_rounded,
              label: 'Rest timer alerts',
              detail: 'Managed in your device settings',
              onTap: null,
            ),
            const SizedBox(height: 26),
            const _SectionLabel('Privacy'),
            const SizedBox(height: 10),
            const _SettingsTile(
              key: Key('settings-privacy-policy'),
              icon: Icons.privacy_tip_outlined,
              label: 'On this device',
              detail:
                  'Workouts stay in a local database. TrainerOne does not upload them.',
              onTap: null,
            ),
            if (kDebugMode) ...[
              const SizedBox(height: 26),
              const _SectionLabel('Developer'),
              const SizedBox(height: 10),
              _SettingsTile(
                key: const Key('settings-animation-lab'),
                icon: Icons.science_outlined,
                label: 'Animation lab',
                detail: 'Motion primitives and timing',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnimationLabPage()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      fontSize: 10.5,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.1,
    ),
  );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.detail,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String detail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final secondary = scheme.onSurfaceVariant;
    return Material(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 13, 12, 13),
          child: Row(
            children: [
              Icon(icon, size: 19, color: secondary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -.15,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      detail,
                      style: TextStyle(
                        color: secondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(Icons.chevron_right_rounded, size: 19, color: secondary),
            ],
          ),
        ),
      ),
    );
  }
}
