import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePersonEntry extends StatefulWidget {
  const CreatePersonEntry({Key? key}) : super(key: key);

  @override
  _CreatePersonEntryState createState() => _CreatePersonEntryState();
}

class _CreatePersonEntryState extends State<CreatePersonEntry> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _phoneNameController = TextEditingController();

  Contact? _selectedContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _getContact();
              },
              child: Text('Select Contact'),
            ),
            SizedBox(height: 16.0),
            if (_selectedContact != null) ...[
              Text(
                'Selected Contact:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: (_selectedContact!.avatar != null &&
                        _selectedContact!.avatar!.isNotEmpty)
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(_selectedContact!.avatar!))
                    : CircleAvatar(child: Text(_selectedContact!.initials())),
                title: Text(_selectedContact!.displayName ?? ''),
              ),
            ],
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNameController,
              decoration: InputDecoration(
                labelText: 'Phone Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Action for creating account
                // Add your logic here
              },
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getContact() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _selectedContact = contacts.first;
      });
    } else {
      // Handle the scenario when permission is not granted
    }
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      permission = await Permission.contacts.request();
    }
    return permission;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
