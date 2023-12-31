import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 1;
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _performSearch(String query) {
    List<String> dummyData = [
      "Result 1",
      "Result 2",
      "Result 3",
      // ... weitere Ergebnisse
    ];

    setState(() {
      _searchResults = dummyData
          .where((result) => result.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.search, color: Color(0xFFFF7A00)), // Farbe für Lupe geändert
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Who are you looking for?',
                        border: InputBorder.none,
                      ),
                      cursorColor: Color(0xFFFF7A00), // Farbe für Cursor geändert
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      _performSearch(_searchController.text);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text('No results found.'),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          color: Color(0xFFFF7A00),
                          height: 2,
                        );
                      },
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchResults[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        context: context,
      ),
    );
  }
}
