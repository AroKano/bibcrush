import 'package:flutter/material.dart';
import '../components/custom_nav_bar.dart';

//DAMIT WIR ÜBERHAUPT WAS HABEN FÜR DIE NAVIGATION BAR; KANN ALLES GEÄNDERT WERDEN
//AUßER KLASSENNAME

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  int _selectedIndex = 0;
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter your search query',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text('No results found'),
                    )
                  : ListView.builder(
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
        selectedIndex: 3,
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
