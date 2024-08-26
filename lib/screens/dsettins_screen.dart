import 'package:flutter/material.dart';

class DSettinsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings
            AnimatedSettingsCard(
              icon: Icons.person,
              title: 'Account',
              children: [
                SettingsTile(
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () {
                    // Handle edit profile tap
                  },
                ),
                SettingsTile(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {
                    // Handle change password tap
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            // Notification Settings
            AnimatedSettingsCard(
              icon: Icons.notifications,
              title: 'Notifications',
              children: [
                SettingsTile(
                  icon: Icons.notifications_active,
                  title: 'Push Notifications',
                  onTap: () {
                    // Handle push notifications tap
                  },
                ),
                SettingsTile(
                  icon: Icons.email,
                  title: 'Email Notifications',
                  onTap: () {
                    // Handle email notifications tap
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            // Communication Settings
            AnimatedSettingsCard(
              icon: Icons.chat,
              title: 'Communication',
              children: [
                SettingsTile(
                  icon: Icons.phone,
                  title: 'Phone Calls',
                  onTap: () {
                    // Handle phone calls tap
                  },
                ),
                SettingsTile(
                  icon: Icons.message,
                  title: 'Messages',
                  onTap: () {
                    // Handle messages tap
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedSettingsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<SettingsTile> children;

  const AnimatedSettingsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  _AnimatedSettingsCardState createState() => _AnimatedSettingsCardState();
}

class _AnimatedSettingsCardState extends State<AnimatedSettingsCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.icon, color: Colors.teal),
                  SizedBox(width: 16),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.teal,
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: _animation,
                axisAlignment: 1.0,
                child: Column(
                  children: widget.children.map((child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: child,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.teal),
      onTap: onTap,
    );
  }
}
