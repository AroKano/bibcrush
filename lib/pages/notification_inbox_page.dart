import 'package:flutter/material.dart';
import 'chat_page.dart';
import '../components/custom_nav_bar.dart';
import 'package:bibcrush/pages/profile_page.dart';
import 'package:bibcrush/pages/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 2),
              ),
            ],
            color: colors.background,
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
            ),
            title: Center(
                child: Image.asset(
                  'assets/bibcrush_logo_top.png',
                  width: 60,
                  height: 60,
                )
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
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
            color: colors.background,
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
    final ColorScheme colors = Theme.of(context).colorScheme;
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('your_chat_collection')
        .where('participants', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No messages yet.'));
        }

        var chats = snapshot.data!.docs;

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            var chatData = chats[index].data() as Map<String, dynamic>;
            String peerId = chatData['peerId'];
            String peerName = chatData['peerName'];
            String peerImageUrl = chatData['peerImageUrl'];


            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(peerImageUrl),
              ),
              title: Text(peerName),
              subtitle: Text('Last message...'),
              trailing: Text('Time'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      peerName: peerName,
                      peerImageUrl: peerImageUrl,
                      peerId: peerId,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildNotificationsList() {
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

