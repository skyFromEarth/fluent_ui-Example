import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class NavigationViewExample extends StatefulWidget {
  @override
  _NavigationViewExampleState createState() => _NavigationViewExampleState();
}

class _NavigationViewExampleState extends State<NavigationViewExample> {
  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.open;
  String pageTransition = 'Default';
  String indicator = 'Sticky';

  static const List<String> pageTransitions = [
    'Default',
    'Entrance',
    'Drill in',
    'Horizontal',
  ];

  static final Map<String, Widget> indicators = {
    'Sticky': const StickyNavigationIndicator(),
    'End': const EndNavigationIndicator(),
  };

  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const Center(child: Text('Home Page')),
    ),
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(FluentIcons.issue_tracking),
      title: const Text('Track orders'),
      infoBadge: const InfoBadge(source: Text('8')),
      body: const Center(child: Text('Track Orders Page')),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.disable_updates),
      title: const Text('Disabled Item'),
      body: const Center(child: Text('Disabled Page')),
      enabled: false,
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      body: const Center(child: Text('Account Page')),
      items: [
        PaneItemHeader(header: const Text('Apps')),
        PaneItem(
          icon: const Icon(FluentIcons.mail),
          title: const Text('Mail'),
          body: const Center(child: Text('Mail Page')),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.calendar),
          title: const Text('Calendar'),
          body: const Center(child: Text('Calendar Page')),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: NavigationView(
        appBar: const NavigationAppBar(
          title: Text('NavigationView Example'),
        ),
        pane: NavigationPane(
          selected: topIndex,
          onChanged: (index) => setState(() => topIndex = index),
          displayMode: displayMode,
          indicator: indicators[indicator],
          header: const Text('Pane Header'),
          items: items,
          footerItems: [
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('Settings'),
              body: const Center(child: Text('Settings Page')),
            ),
            PaneItemAction(
              icon: const Icon(FluentIcons.add),
              title: const Text('Add New Item'),
              onTap: () {
                items.add(
                  PaneItem(
                    icon: const Icon(FluentIcons.new_folder),
                    title: const Text('New Item'),
                    body: const Center(child: Text('This is a newly added Item')),
                  ),
                );
                setState(() {});
              },
            ),
          ],
        ),
        transitionBuilder: pageTransition == 'Default'
            ? null
            : (child, animation) {
                switch (pageTransition) {
                  case 'Entrance':
                    return EntrancePageTransition(
                      animation: animation,
                      child: child,
                    );
                  case 'Drill in':
                    return DrillInPageTransition(
                      animation: animation,
                      child: child,
                    );
                  case 'Horizontal':
                    return HorizontalSlidePageTransition(
                      animation: animation,
                      child: child,
                    );
                  default:
                    throw UnsupportedError(
                      '$pageTransition is not a supported transition',
                    );
                }
              },
      ),
    );
  }
}

void main() {
  runApp(NavigationViewExample());
}
