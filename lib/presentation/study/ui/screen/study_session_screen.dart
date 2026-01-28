import 'package:flutter/material.dart';
import 'package:e4u_application/presentation/common/base_wrapper.dart';
import 'package:e4u_application/presentation/study/ui/controllers/study_session_controller.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_session_mobile_screen.dart';
import 'package:e4u_application/presentation/study/ui/screen/study_session_desktop_screen.dart';

/// Main study session screen using BaseWrapper for responsive design.
class StudySessionScreen extends StatefulWidget {
  const StudySessionScreen({super.key});

  @override
  State<StudySessionScreen> createState() => _StudySessionScreenState();
}

class _StudySessionScreenState extends State<StudySessionScreen> {
  late final StudySessionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StudySessionController();
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    await _controller.loadUnits('mock_curriculum');

    // Auto-start session with mock data for demo
    // TODO: Replace with proper unit selection flow
    if (_controller.availableUnits.isNotEmpty) {
      // Select first unit and start session
      _controller.selectUnit(_controller.availableUnits.first);
      await _controller.startSession();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleClose() {
    // TODO: Navigate back or show confirmation dialog
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      mobile: StudySessionMobileScreen(
        controller: _controller,
        onClose: _handleClose,
      ),
      desktop: StudySessionDesktopScreen(
        controller: _controller,
        onClose: _handleClose,
      ),
    );
  }
}
