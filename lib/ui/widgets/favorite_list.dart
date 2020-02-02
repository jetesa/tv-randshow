import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';

import '../../core/models/tvshow_details.dart';
import '../../core/viewmodels/widgets/favorite_list_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
import 'fav_widget.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<FavoriteListModel>(
      model: FavoriteListModel(databaseService: Provider.of(context)),
      builder: (BuildContext context, FavoriteListModel model, Widget child) =>
          SafeArea(
        child: Container(
          child: model.busy
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  /// TODO: Dynamic load database with [PagewiseGridView]
                  child: PagewiseGridView<TvshowDetails>.count(
                    physics: const BouncingScrollPhysics(),
                    pageSize: 20,
                    crossAxisCount: 2,
                    showRetry: false,
                    padding: DEFAULT_INSESTS,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    errorBuilder: (BuildContext context, Object dyna) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            FlutterI18n.translate(
                                context, 'app.fav.error_message'),
                            style: StyleText.MESSAGES,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    noItemsFoundBuilder: (BuildContext context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            FlutterI18n.translate(
                                context, 'app.fav.empty_message'),
                            style: StyleText.MESSAGES,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    itemBuilder:
                        (BuildContext context, dynamic item, int index) =>
                            FavWidget(tvshowDetails: item),
                    pageFuture: (int pageIndex) => model.loadFavs(),
                  ),

                  // GridView.builder(
                  //   physics: const BouncingScrollPhysics(),
                  //   semanticChildCount: model.listTvShow.length,
                  //   padding: DEFAULT_INSESTS,
                  //   itemCount: model.listTvShow.length,
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //           mainAxisSpacing: 8.0,
                  //           crossAxisSpacing: 8.0,
                  //           crossAxisCount: 2),
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return model.listTvShow[index];
                  //   },
                  // ),
                ),
        ),
      ),
    );
  }
}