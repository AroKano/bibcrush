import 'package:flutter/material.dart';
import 'chat_page.dart';
import '../components/custom_nav_bar.dart';


class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InboxNotificationsPage();
  }
}

class InboxNotificationsPage extends StatefulWidget {
  @override
  _InboxNotificationsPageState createState() => _InboxNotificationsPageState();
}

class _InboxNotificationsPageState extends State<InboxNotificationsPage> {
  int _currentBottomNavIndex = 3;
  int _currentInnerTabIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _currentBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
            title: Center(
              child: FlutterLogo(size: 32),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(Icons.search, color: Colors.grey),
                  onPressed: () {
                    // Implement the search functionality
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 1),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton(title: 'Messages', index: 0, notificationCount: 4),
                SizedBox(width: 10),
                _buildTabButton(title: 'Notifications', index: 1, notificationCount: 2),
              ],
            ),
          ),
          Expanded(
            child: _currentInnerTabIndex == 0 ? _buildMessagesList() : _buildNotificationsList(),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        onTabChange: _onTabChange,
        selectedIndex: _currentBottomNavIndex,
        context: context,
      ),
    );
  }

  Widget _buildTabButton({required String title, required int index, required int notificationCount}) {
    bool isSelected = _currentInnerTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentInnerTabIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 17.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Positioned(
              top: -4,
              right: -4,
              child: isSelected
                  ? Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$notificationCount',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    // Placeholder for messages list
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(),
            title: Text('Mike Smith'),
            subtitle: Text('Hi, I saw you study Mediendesign...'),
            trailing: Text('12 mins ago'),
            onTap: () {
              // When a message is tapped, navigate to the ChatScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    peerName: 'Mike Smith', // Replace with actual data
                    peerImageUrl: 'https://via.placeholder.com/150', // Replace with actual data
                  ),
                ),
              );
            }
        );
      },
    );
  }

  Widget _buildNotificationsList() {
    // Placeholder for notifications list
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(),
          title: Text('New Follower'),
          subtitle: Text('Anna99 started following you.'),
          trailing: Text('1 hr ago'),
        );
      },
    );
  }
}

