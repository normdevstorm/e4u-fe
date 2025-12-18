import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/presentation/common/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // for StatefulNavigationShell

class SkeletonDesktopPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar for desktop
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.primaryColorLight,
      ),
      body: SafeArea(
        child: Row(
          children: [
            // Permanent left-side drawer
            SizedBox(
              width: drawerWidth,
              child: Material(
                elevation: 1,
                color: Theme.of(context).colorScheme.surface,
                child: NavigationDrawer(
                  selectedIndex: child.currentIndex,
                  onDestinationSelected: (index) => child.goBranch(index),
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Text(
                        'Menu',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(height: 1),

                    NavigationDrawerDestination(
                      icon: AppIcon(
                        assetPath: IconManager.home,
                        size: 22,
                        color: ColorManager.iconColorLight,
                      ),
                      selectedIcon: AppIcon(
                        assetPath: IconManager.home,
                        size: 22,
                        color: ColorManager.primaryColorLight,
                      ),
                      label: Text('Home'),
                    ),
                    NavigationDrawerDestination(
                      icon: AppIcon(
                        assetPath: IconManager.bookOpen,
                        size: 22,
                        color: ColorManager.iconColorLight,
                      ),
                      selectedIcon: AppIcon(
                        assetPath: IconManager.bookOpen,
                        size: 22,
                        color: ColorManager.primaryColorLight,
                      ),
                      label: Text('Learn'),
                    ),
                    NavigationDrawerDestination(
                      icon: AppIcon(
                        assetPath: IconManager.analytics,
                        size: 22,
                        color: ColorManager.iconColorLight,
                      ),
                      selectedIcon: AppIcon(
                        assetPath: IconManager.analytics,
                        size: 22,
                        color: ColorManager.primaryColorLight,
                      ),
                      label: Text('Stats'),
                    ),
                    NavigationDrawerDestination(
                      icon: AppIcon(
                        assetPath: IconManager.setting,
                        size: 22,
                        color: ColorManager.iconColorLight,
                      ),
                      selectedIcon: AppIcon(
                        assetPath: IconManager.setting,
                        size: 22,
                        color: ColorManager.primaryColorLight,
                      ),
                      label: Text('Settings'),
                    ),

                    SizedBox(height: 8),
                    Divider(height: 1),
                    // Optional footer: profile / sign out / theme toggle…
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
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
