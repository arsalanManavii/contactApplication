import 'package:contact_application/state_managment/provider.dart';
import 'package:contact_application/util/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteContactsScreen extends StatelessWidget {
  const FavoriteContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مورد علاقه ها'),
        ),
        body: Consumer<ContactProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.favoriteContactList.length,
              itemBuilder: (BuildContext context, int index) {
                if (index != value.favoriteContactList.length - 1) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          value.favoriteContactList[index].cName!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          value.favoriteContactList[index].cPhoneNumber!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: Icon(Icons.person_outline,
                            color: Theme.of(context).iconTheme.color),
                        trailing: IconButton(
                          onPressed: () {
                            value.updateFavoriteContact(
                                value.favoriteContactList[index]);
                          },
                          icon: value.favoriteContactList[index].isLiked == 1
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border),
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
                  return ListTile(
                    title: Text(
                      value.favoriteContactList[index].cName!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      value.favoriteContactList[index].cPhoneNumber!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: Icon(Icons.person_outline,
                        color: Theme.of(context).iconTheme.color),
                    trailing: IconButton(
                      onPressed: () {
                        value.updateFavoriteContact(value.favoriteContactList[index]);
                      },
                      icon: value.favoriteContactList[index].isLiked == 1
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
                              child: const Icon(Icons.favorite),
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Theme.of(context).iconTheme.color,
                            ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
