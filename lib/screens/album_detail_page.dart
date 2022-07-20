import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/album_detail_controller.dart';
import 'package:test_project/widgets/error.dart';
import 'package:test_project/widgets/loading.dart';

class AlbumDetailPage extends StatelessWidget {
  AlbumDetailPage(this.albumId, {Key? key}) : super(key: key);

  final String albumId;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlbumDetailsController>(
      init: AlbumDetailsController(albumId: albumId),
      builder: (albumDetailsController) {
        return Scaffold(
          appBar: AppBar(
            title: Text(albumDetailsController.album?.title ?? ""),
          ),
          body: Builder(builder: (context) {
            if (albumDetailsController.loading) {
              return const CircularLoading();
            }
            if (albumDetailsController.errorMessage != null) {
              return ErrorMessage(
                error: albumDetailsController.errorMessage,
                onRefresh: albumDetailsController.fetchPost,
              );
            }
            return photos();
          }),
        );
      },
    );
  }

  Widget photos() {
    final albumDetailsController = Get.find<AlbumDetailsController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PageView.builder(
        itemCount: albumDetailsController.photos?.length ?? 0,
        itemBuilder: (context, index) {
          final photo = albumDetailsController.photos![index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      photo.url,
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    photo.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${index + 1}/${albumDetailsController.photos?.length}",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
