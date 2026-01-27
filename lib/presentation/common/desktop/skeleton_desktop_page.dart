import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/common/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // for StatefulNavigationShell

class SkeletonDesktopPage extends StatefulWidget {
  const SkeletonDesktopPage({
    super.key,
    required this.title,
    required this.child,
    this.drawerWidth = 280,
    this.maxContentWidth = 1280, // Prevent super-long lines on wide screens
  });

  final String title;
  final StatefulNavigationShell child;
  final double drawerWidth;
  final double maxContentWidth;

  @override
  State<SkeletonDesktopPage> createState() => _SkeletonDesktopPageState();
}

class _SkeletonDesktopPageState extends State<SkeletonDesktopPage> {
  static const double _collapsedWidth = 80;
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final double currentDrawerWidth =
        _isCollapsed ? _collapsedWidth : widget.drawerWidth;

    return Scaffold(
      // No app bar on desktop layout as requested
      body: SafeArea(
        child: Row(
          children: [
            // Collapsible left-side drawer
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: currentDrawerWidth,
              child: Material(
                elevation: 1,
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gmail-like circular collapse / expand button at the top
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          setState(() {
                            _isCollapsed = !_isCollapsed;
                          });
                        },
                        child: Material(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withOpacity(0.8),
                          shape: const CircleBorder(),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.menu,
                              size: 22,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: NavigationDrawer(
                        selectedIndex: widget.child.currentIndex,
                        onDestinationSelected: (index) =>
                            widget.child.goBranch(index),
                        tilePadding: const EdgeInsets.symmetric(
                          vertical: 14, // slightly wider vertical gap
                          horizontal: 16,
                        ),
                        children: [
                          const Divider(height: 1),
                          NavigationDrawerDestination(
                            icon: const AppIcon(
                              assetPath: IconManager.home,
                              size: 22,
                              color: ColorManager.iconColorLight,
                            ),
                            selectedIcon: const AppIcon(
                              assetPath: IconManager.home,
                              size: 22,
                              color: ColorManager.primaryColorLight,
                            ),
                            label: _isCollapsed
                                ? const SizedBox.shrink()
                                : const Text('Home'),
                          ),
                          NavigationDrawerDestination(
                            icon: const AppIcon(
                              assetPath: IconManager.bookOpen,
                              size: 22,
                              color: ColorManager.iconColorLight,
                            ),
                            selectedIcon: const AppIcon(
                              assetPath: IconManager.bookOpen,
                              size: 22,
                              color: ColorManager.primaryColorLight,
                            ),
                            label: _isCollapsed
                                ? const SizedBox.shrink()
                                : const Text('Learn'),
                          ),
                          NavigationDrawerDestination(
                            icon: const AppIcon(
                              assetPath: IconManager.analytics,
                              size: 22,
                              color: ColorManager.iconColorLight,
                            ),
                            selectedIcon: const AppIcon(
                              assetPath: IconManager.analytics,
                              size: 22,
                              color: ColorManager.primaryColorLight,
                            ),
                            label: _isCollapsed
                                ? const SizedBox.shrink()
                                : const Text('Stats'),
                          ),
                          NavigationDrawerDestination(
                            icon: const AppIcon(
                              assetPath: IconManager.setting,
                              size: 22,
                              color: ColorManager.iconColorLight,
                            ),
                            selectedIcon: const AppIcon(
                              assetPath: IconManager.setting,
                              size: 22,
                              color: ColorManager.primaryColorLight,
                            ),
                            label: _isCollapsed
                                ? const SizedBox.shrink()
                                : const Text('Settings'),
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const VerticalDivider(width: 1),

            // Content area (centered and bounded for readability on desktop/web)
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: widget.maxContentWidth),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
