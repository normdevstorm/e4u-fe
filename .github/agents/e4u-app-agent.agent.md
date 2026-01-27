---
description: 'Describe what this custom agent does and when to use it.'
tools: ['vscode', 'execute', 'read', 'agent', 'edit', 'search', 'web', 'dart-sdk-mcp-server/*', 'figma/*', 'todo']
---
- Apply Clean Architecture
- Always refractor and if neccessary, refractor to another file
- Use BaseWrapper for responsive design
- Use GoRouter for navigation
- Use Bloc for state management
- Use dependency injection
- When UI is complex, separate into smaller widgets, reusable if possible
- Use constants for strings, colors, dimens, etc.
- Use extension methods for common operations
- Use proper naming conventions
- Remember to leave a TODO comment and code which is ready to be developed further such as Button actions, API calls, etc.
- Use comments to explain complex logic
- Remember to apply the best practice
- Optimize rebuilds and performance where possible
- Apply optimization techniques for application performance
- Always implement UI responsive using BaseWrapper + ScreenUtils


- Analyze and respect Figma’s layout, spacing, and hierarchy in Flutter widgets.
- Name components in Flutter consistently with their Figma counterparts for traceability.
- Use Flutter’s design tokens or theme where possible instead of hardcoding colors, fonts, and sizes—match Figma styles via central theme management. (if the exact color exists)
- Extract common UI elements into reusable widgets, reflecting Figma components/instances, and extract them into files, which can be reused in other screens further (genralize and parameteralize).
- Use proper constraints and responsive layouts (ScreenUtils)(Expanded, Flexible, MediaQuery, etc.) to support screen sizes, as reflected in Figma responsive layouts.
- For icons and images, use assets exported from Figma or ensure exact match via Flutter’s equivalent vector assets.
- Ensure text styles (font, weight, spacing) follow Figma typography specs through TextTheme or custom stylesheets.
- Validate against Figma prototypes for user flows and micro-interactions (e.g., transitions, hover states), using Flutter animations where appropriate.
- Regularly check accessibility—contrast, font sizes, touch targets—matching Figma accessibility guidelines.
- Separate design-system components, pages, and logic in codebase to maintain Clean Architecture.
- Document deviations from Figma with reason and seek designer approval where necessary.
- Always wrap mobile and desktop screen in base wrapper, and pass event handler, controller, bloc from outside.
