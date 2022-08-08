import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreadCrumbProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          '/new': (context) => const NewBreadCrumbsWidget(),
        },
      ),
    );
  }
}

class BreadCrumb {
  final String uuid;
  bool isActive;
  final String name;

  BreadCrumb({required this.isActive, required this.name})
      : uuid = const Uuid().v4();

  void active() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  String get title => name + (isActive ? ' > ' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];

  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.active();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;

  const BreadCrumbWidget({
    Key? key,
    required this.breadCrumbs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map((breadCrumb) {
        return Text(
          breadCrumb.title,
          style: TextStyle(
            color: breadCrumb.isActive ? Colors.blue : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Provider'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<BreadCrumbProvider>(
            builder: (context, value, child) {
              return BreadCrumbWidget(breadCrumbs: value.items);
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/new');
            },
            child: const Text('Add new bread crumb'),
          ),
          TextButton(
            onPressed: () {
              final provider = context.read<BreadCrumbProvider>();
              provider.reset();
            },
            child: const Text('Reset'),
          )
        ],
      ),
    );
  }
}

class NewBreadCrumbsWidget extends StatefulWidget {
  const NewBreadCrumbsWidget({Key? key}) : super(key: key);

  @override
  State<NewBreadCrumbsWidget> createState() => _NewBreadCrumbsWidgetState();
}

class _NewBreadCrumbsWidgetState extends State<NewBreadCrumbsWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bread Crumbs'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: 'Enter new bread crumbs here!'),
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text;
              if (text.isNotEmpty) {
                final breadCrumb = BreadCrumb(isActive: false, name: text);
                context.read<BreadCrumbProvider>().add(breadCrumb);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
