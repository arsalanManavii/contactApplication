import 'package:contact_application/screens/add_contact_screen.dart';
import 'package:contact_application/screens/edit_contact_screen.dart';
import 'package:contact_application/screens/favorite_contacts_screen.dart';
import 'package:contact_application/state_managment/provider.dart';
import 'package:contact_application/state_managment/theme_provider.dart';
import 'package:contact_application/util/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FabStateProvider>(context);
    var contactProvider = Provider.of<ContactProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var switchIcon = Preferences.isDarkTheme
        ? const Icon(Icons.light_mode_outlined)
        : const Icon(Icons.dark_mode);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: Consumer<FabStateProvider>(
          builder: (context, value, child) {
            return Visibility(
              visible: value.isFABVisible,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => ContactProvider(),
                          ),
                        ],
                        child: const AddContactScreen(),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                ),
              ),
            );
          },
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) =>
                            ContactProvider()..favoriteContacts(),
                        child: const FavoriteContactsScreen()),
                  ),
                );
              },
              icon: Icon(
                Icons.favorite_outline,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            IconButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              icon: switchIcon,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
          title: const Text('مخاطب ها'),
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (contactProvider.contactList.length >= 10) {
              provider.changeVisibility(notification);
            }
            return true;
          },
          child: Consumer<ContactProvider>(
            builder: (context, value, child) {
              value.contacts();
              return ListView.builder(
                itemCount: value.contactList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index != value.contactList.length - 1) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => ContactProvider(),
                                  child: EditContactScreen(
                                    id: value.contactList[index].id!,
                                    name: value.contactList[index].cName!,
                                    phoneNumber:
                                        value.contactList[index].cPhoneNumber!,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              value.contactList[index].cName!,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            subtitle: Text(
                              value.contactList[index].cPhoneNumber!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            leading: IconButton(
                              onPressed: () {
                                value.deleteContact(value.contactList[index]);
                              },
                              icon: Icon(
                                Icons.delete_outline,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                value.updateFavoriteContact(
                                    value.contactList[index]);
                              },
                              icon: value.contactList[index].isLiked == 1
                                  ? Theme(
                                      data: Preferences.isDarkTheme
                                          ? Theme.of(context).copyWith(
                                              iconTheme: Theme.of(context)
                                                  .iconTheme
                                                  .copyWith(
                                                      color: Colors.purple),
                                            )
                                          : Theme.of(context).copyWith(
                                              iconTheme: Theme.of(context)
                                                  .iconTheme
                                                  .copyWith(color: Colors.red),
                                            ),
                                      child: const Icon(Icons.favorite))
                                  : Icon(
                                      Icons.favorite_border,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                          indent: 15,
                          endIndent: 15,
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => ContactProvider(),
                              child: EditContactScreen(
                                id: value.contactList[index].id!,
                                name: value.contactList[index].cName!,
                                phoneNumber:
                                    value.contactList[index].cPhoneNumber!,
                              ),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          value.contactList[index].cName!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          value.contactList[index].cPhoneNumber!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: IconButton(
                          onPressed: () {
                            value.deleteContact(value.contactList[index]);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            value.updateFavoriteContact(
                                value.contactList[index]);
                          },
                          icon: value.contactList[index].isLiked == 1
                              ? Theme(
                                  data: Preferences.isDarkTheme
                                      ? Theme.of(context).copyWith(
                                          iconTheme: Theme.of(context)
                                              .iconTheme
                                              .copyWith(color: Colors.purple),
                                        )
                                      : Theme.of(context).copyWith(
                                          iconTheme: Theme.of(context)
                                              .iconTheme
                                              .copyWith(color: Colors.red),
                                        ),
                                  child: const Icon(
                                    Icons.favorite,
                                  ),
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
