import 'package:flutter/material.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/curriculum/domain/models/curriculum_model.dart';

/// Shared controller for learning course screen logic.
/// Manages curriculum list, selection, and filtering.
class LearningCourseController extends ChangeNotifier {
  LearningCourseController() {
    _loadCurriculums();
  }

  // List of all curriculums
  List<CurriculumModel> _curriculums = [];
  List<CurriculumModel> get curriculums => _curriculums;

  // Get current curriculum (the one marked as current, placed on top)
  CurriculumModel? get currentCurriculum =>
      _curriculums.where((c) => c.isCurrent).firstOrNull;

  // Get sorted curriculums with current on top
  List<CurriculumModel> get sortedCurriculums {
    final sorted = List<CurriculumModel>.from(_curriculums);
    sorted.sort((a, b) {
      // Current curriculum always comes first
      if (a.isCurrent && !b.isCurrent) return -1;
      if (!a.isCurrent && b.isCurrent) return 1;
      // Then sort by progress (higher progress first)
      return b.progress.compareTo(a.progress);
    });
    return sorted;
  }

  // Track selected curriculum filter
  String selectedCurriculumFilter = 'All Curriculums';

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Load curriculums from data source
  /// TODO: Replace with actual API call
  void _loadCurriculums() {
    _isLoading = true;
    // Using mock data for now
    _curriculums = CurriculumModel.mockCurriculums();
    _isLoading = false;
    notifyListeners();
  }

  /// Reload curriculums
  Future<void> refreshCurriculums() async {
    _isLoading = true;
    notifyListeners();

    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    _curriculums = CurriculumModel.mockCurriculums();

    _isLoading = false;
    notifyListeners();
  }

  /// Set a curriculum as current
  void setCurrentCurriculum(String curriculumId) {
    _curriculums = _curriculums.map((c) {
      return c.copyWith(isCurrent: c.id == curriculumId);
    }).toList();
    notifyListeners();
  }

  /// Set selected curriculum filter
  void setSelectedCurriculumFilter(String filter) {
    selectedCurriculumFilter = filter;
    notifyListeners();
  }

  /// Show curriculum filter dropdown bottom sheet
  Future<void> showCurriculumFilterDropdown(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: ColorManager.baseWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorManager.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Filter Curriculums',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.grey950,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFilterOption(context, 'All Curriculums'),
            _buildFilterOption(context, 'In Progress'),
            _buildFilterOption(context, 'Not Started'),
            _buildFilterOption(context, 'Completed'),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String filter) {
    final bool isSelected = selectedCurriculumFilter == filter;
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          setSelectedCurriculumFilter(filter);
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: isSelected ? ColorManager.purpleLight : Colors.transparent,
          child: Text(
            filter,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color:
                  isSelected ? ColorManager.purpleHard : ColorManager.grey950,
            ),
          ),
        ),
      ),
    );
  }
}
