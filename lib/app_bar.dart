import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/favorites_screen.dart';
import 'package:flutter_notes/screens/search_screen.dart';

class app_bar extends StatelessWidget implements PreferredSizeWidget {
  // final int count;
  // app_bar(this.count);
  @override
  Size get preferredSize =>
      Size.fromHeight(70.0); // Set the desired height of the custom app bar

  Color get color => Colors.black12;
  @override
  Widget build(BuildContext context) {
    //   return AppBar(
    //     backgroundColor: Colors.purpleAccent.shade100,
    //     leading: IconButton(
    //       icon: Icon(Icons.cancel),
    //       onPressed: () {
    //         selectionModel.clearSelection();
    //       },
    //     ),
    //     title: Text('${selectionModel.selectedCount} selected'),
    //     actions: [
    //       IconButton(
    //         icon: Icon(Icons.edit),
    //         onPressed: () {
    //           _handleEditAction(selectionModel);
    //         },
    //       ),
    //       IconButton(
    //         icon: Icon(Icons.delete),
    //         onPressed: () {
    //           _handleDeleteAction(selectionModel);
    //         },
    //       ),
    //     ],
    //   );
    // }
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(10),
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {
                // Open navigation bar
                Scaffold.of(context).openDrawer(); // Open navigation drawer
              },
            ),
            Expanded(
              child: InkWell(
                child: Text(
                  "Search your notes",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchScreen()));
                },
              ),
            ),
            //     .onTap(() {
            //   print("Search your notes");
            // }),
            IconButton(
              icon: const Icon(Icons.favorite_outline_rounded),
              onPressed: () {
                // Open the favorites screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => favorites_screen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void _handleEditAction(SelectionModel selectionModel) {
//   // Handle edit action for selected items
//   selectionModel.clearSelection();
// }
//
// void _handleDeleteAction(SelectionModel selectionModel) {
//   // Handle delete action for selected items
//   selectionModel.clearSelection();
// }
