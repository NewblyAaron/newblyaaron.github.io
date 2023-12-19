import 'package:flutter/material.dart';
import 'package:newbly_flutter_website/abstracts.dart';
import 'package:newbly_flutter_website/screens/home/pages/about_page.dart';
import 'package:newbly_flutter_website/screens/home/pages/contact_page.dart';
import 'package:newbly_flutter_website/screens/home/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => _HomeScreenView(this);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pageKey = GlobalKey();
  final pages = const [HomePage(), AboutPage(), ContactPage()];
  final pageController = PageController(keepPage: true);

  int selectedIndex = 0;

  void setSelectedDestination(int value) {
    setState(() => selectedIndex = value);
    pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}

class _HomeScreenView extends WidgetView<HomeScreen, _HomeScreenState> {
  const _HomeScreenView(super.state);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (builderContext, constraints) {
        if (constraints.maxWidth > 800) {
          return buildTabletScaffold();
        } else {
          return buildMobileScaffold(builderContext);
        }
      },
    );
  }

  Scaffold buildMobileScaffold(BuildContext context) {
    return Scaffold(
      key: state.scaffoldKey,
      body: Column(
        children: [
          buildPageView(),
          BottomAppBar(
            elevation: 8,
            height: 64,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => buildModalBottomNav(context),
                    icon: const Icon(Icons.menu_rounded))
              ],
            ),
          )
        ],
      ),
    );
  }

  Scaffold buildTabletScaffold() {
    return Scaffold(
      key: state.scaffoldKey,
      body: Row(
        children: [buildNavRail(), buildPageView()],
      ),
    );
  }

  Widget buildNavRail() {
    const destinations = [
      NavigationRailDestination(
          icon: Icon(Icons.home_rounded), label: Text("Home")),
      NavigationRailDestination(
          icon: Icon(Icons.person_rounded), label: Text("About")),
      NavigationRailDestination(
          icon: Icon(Icons.contact_support_rounded), label: Text("Contact")),
    ];

    return LayoutBuilder(
      builder: (context, constraints) => NavigationRail(
        elevation: 8,
        groupAlignment: constraints.maxWidth > 800 ? 0 : 0.82,
        extended: constraints.maxWidth > 800 ? false : true,
        labelType: constraints.maxWidth > 800
            ? NavigationRailLabelType.selected
            : NavigationRailLabelType.none,
        destinations: destinations,
        selectedIndex: state.selectedIndex,
        onDestinationSelected: state.setSelectedDestination,
      ),
    );
  }

  Future<dynamic> buildModalBottomNav(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: StatefulBuilder(builder: (context, setState) {
            final destinations = [
              ListTile(
                title: const Text("Home"),
                leading: const Icon(Icons.home_rounded),
                selected: state.selectedIndex == 0,
                onTap: () {
                  state.setSelectedDestination(0);
                  setState(() {});
                },
              ),
              ListTile(
                title: const Text("About"),
                leading: const Icon(Icons.person_rounded),
                selected: state.selectedIndex == 1,
                onTap: () {
                  state.setSelectedDestination(1);
                  setState(() {});
                },
              ),
              ListTile(
                title: const Text("Contact"),
                leading: const Icon(Icons.contact_support_rounded),
                selected: state.selectedIndex == 2,
                onTap: () {
                  state.setSelectedDestination(2);
                  setState(() {});
                },
              ),
            ];

            return ListView(
              children: destinations,
            );
          }),
        );
      },
    );
  }

  Expanded buildPageView() {
    return Expanded(
        child: PageView(
      key: state.pageKey,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: state.pageController,
      children: state.pages,
    ));
  }
}
