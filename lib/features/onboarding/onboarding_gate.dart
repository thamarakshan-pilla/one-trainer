import 'package:flutter/material.dart';

import '../../domain/app_preferences.dart';
import 'onboarding_flow.dart';

/// Shows the introduction once, then the app.
///
/// The decision is made from the database rather than from a flag in memory,
/// so a reinstall introduces the app again and an update never does. While the
/// answer is being read the screen stays on the app's own background: a
/// spinner here would flash on every cold start for the sake of a query that
/// takes a millisecond.
class OnboardingGate extends StatefulWidget {
  const OnboardingGate({
    super.key,
    required this.preferences,
    required this.child,
  });

  final AppPreferencesRepository preferences;
  final Widget child;

  @override
  State<OnboardingGate> createState() => _OnboardingGateState();
}

class _OnboardingGateState extends State<OnboardingGate> {
  late Future<OnboardingRecord> _record;
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _record = widget.preferences.readOnboarding();
  }

  Future<void> _finish(OnboardingRecord record) async {
    // Shown first, saved after: a write that fails should not strand someone
    // on the welcome screen, it should only mean they see it again next time.
    setState(() => _dismissed = true);
    await widget.preferences.saveOnboarding(record);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<OnboardingRecord>(
    future: _record,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const ColoredBox(color: Color(0xff151714));
      }
      // A failed read is treated as a first run. Repeating a welcome is a
      // smaller harm than skipping it for someone who never saw it.
      final seen = snapshot.data?.isComplete ?? false;
      if (seen || _dismissed) return widget.child;
      return OnboardingFlow(onFinished: _finish);
    },
  );
}
