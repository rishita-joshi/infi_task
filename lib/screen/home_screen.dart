import 'package:api_task_glogin/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       // DrawerHeader(child: )
      //     ],
      //   ),
      // ),
      body: FutureBuilder(
          future: ApiService().getPhotosApi(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapShot.data!.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100,
                      width: 300,
                      child: ListTile(
                        title: Text(snapShot.data![index].title.toString()),
                        subtitle: Text(snapShot.data![index].id.toString()),
                        leading: CachedNetworkImage(
                          imageUrl:
                              snapShot.data![index].thumbnailUrl.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.red, BlendMode.colorBurn)),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    );
                  });
            }
            if (snapShot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator());
            }

            return Text(snapShot.error.toString());
          }),
    );
  }
}
