import 'package:contact_application/state_managment/provider.dart';
import 'package:contact_application/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditContactScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final int id;
  EditContactScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.id,
  });

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController contactNameController;
  late TextEditingController contactNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactNameController = TextEditingController(text: widget.name);
    contactNumberController = TextEditingController(text: widget.phoneNumber);
  }

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
              provider.updateContact(
                widget.id,
                contactNameController.text,
                contactNumberController.text,
              );

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
          title: const Text('ویرایش کردن مخاطب'),
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
