import 'package:contact_application/helper/database_helper.dart';
import 'package:contact_application/model/contact.dart';
import 'package:contact_application/state_managment/provider.dart';
import 'package:contact_application/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}



class _AddContactScreenState extends State<AddContactScreen> {
  var contactNameController = TextEditingController();
  var contactNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String validationText = Utils.validation(
              contactNameController.text,
              contactNumberController.text,
            );
            if (validationText.isEmpty) {
              final contact = Contact(
                cName: contactNameController.text,
                cPhoneNumber: contactNumberController.text,
                isLiked: 0,
              );
              provider.addContact(contact);

              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(validationText),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: const Text('اضافه کردن مخاطب'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: contactNameController,
                decoration: InputDecoration(
                  label: const Text('نام'),
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: contactNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: const Text('شماره تلفن'),
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  prefixText: '98+',
                  prefixStyle: Theme.of(context).textTheme.labelLarge,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
