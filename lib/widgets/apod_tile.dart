import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/apod_model.dart';
import '../utils/theme_data.dart';

class ApodTile extends StatelessWidget {
  const ApodTile({
    super.key,
    required ApodModel apodModel,
    required void Function()? onTap,
  })  : _apodModel = apodModel,
        _onTap = onTap;
  final ApodModel _apodModel;
  final void Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        padding: EdgeInsets.symmetric(vertical: 1.r, horizontal: 1.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: whiteColor,
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: foreGroundColor,
          ),
          child: Stack(
            children: [
              ClipRRect(
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
                  progressIndicatorBuilder: (context, url, downloadProgress) {
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: backGroundColor.withOpacity(0.8)),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      _apodModel.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      _apodModel.date,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
