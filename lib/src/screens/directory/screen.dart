import 'package:flutter/material.dart';
import 'package:hanbit_directory/src/models/contact.dart';
import 'package:hanbit_directory/src/proxy/search_people.dart';
import 'package:hanbit_directory/src/widgets/contact_tile_list.dart';

class DirectoryScreen extends StatefulWidget {
  final SearchPeople searchPeople;

  static const routeName = '/directory';

  const DirectoryScreen(this.searchPeople, {Key? key}) : super(key: key);

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState(searchPeople);
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  final SearchPeople searchPeople;
  final TextEditingController _searchController = TextEditingController();

  _DirectoryScreenState(this.searchPeople);

  bool _isLoading = false;
  List<Contact> _contacts = List.empty();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => _performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String term) async {
    setState(() {
      _isLoading = true;
    });

    var searchResult = await searchPeople.search(term);

    setSearchResult(searchResult);
  }

  void setSearchResult(List<Contact> searchResult) {
    setState(() {
      _contacts = searchResult;
      _isLoading = false;
    });
  }

  Widget body() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
        : ContactTileList(_contacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onSubmitted: (value) => _performSearch(value),
            // onChanged: (value) {
            //   _performSearch(value);
            // },
          ),
        ),
        body: body());
  }
}
