import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:picture_of_the_day/model/apod_model.dart';

import '../../utils/theme_data.dart';

class ApodDetails extends StatelessWidget {
  const ApodDetails({super.key, required ApodModel apodModel})
      : _apodModel = apodModel;
  final ApodModel _apodModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Picture of the Day',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leadingWidth: 75.w,
        leading: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back)),
          ],
        ),
        actions: [
          const Icon(Icons.rocket_launch_outlined, color: foreGroundColor),
          SizedBox(
            width: horizontalPadding,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          margin: EdgeInsets.only(top: verticalMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
            color: foreGroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: CachedNetworkImage(
                      imageUrl: _apodModel.url,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: verticalPadding,
                                horizontal: horizontalPadding,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: verticalMargin,
                                horizontal: horizontalMargin,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radius),
                                color: foreGroundColor,
                              ),
                              child: CircularProgressIndicator(
                                backgroundColor: backGroundColor,
                                strokeWidth: 2.5.r,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    accentColor),
                                value: downloadProgress.totalSize != null
                                    ? downloadProgress.downloaded /
                                        downloadProgress.totalSize!
                                    : null,
                              ),
                            ),
                          ],
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Failed to load Image',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Icon(
                              Icons.error_outline,
                              size: 30,
                              color: accentColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 300.h,
                margin: EdgeInsets.symmetric(
                  vertical: verticalMargin,
                  horizontal: horizontalMargin,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: backGroundColor,
                  ),
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        _apodModel.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        _apodModel.explanation,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              _apodModel.date,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
