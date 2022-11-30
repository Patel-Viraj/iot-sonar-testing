import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../base/extensions/reusable_extension.dart';
import '../base/utils/constants/color_constants.dart';
import '../base/utils/constants/image_constant.dart';
import '../base/utils/constants/size_constants.dart';

class ProfileImageView extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final String? name;
  final bool? isBorder;

  const ProfileImageView(
      {Key? key,
      @required this.imageUrl,
      @required this.size,
      this.name,
      this.isBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size!),
          border: isBorder ?? false
              ? Border.all(color: ColorConstants.primaryColor)
              : null,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => _commonParent(
          context,
          const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorConstants.secondaryColor),
            ),
          )),
      errorWidget: (context, url, error) => _commonParent(context,
          name == null ? _placeHolderView(context) : _getInitialsView()),
      // placeholder: (context, url) =>
      //     _commonParent(context, Center(child: _placeHolderView(context))),
    );
  }

  Widget _placeHolderView(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(
          ImageConstant.icUser,
          width: size,
          fit: BoxFit.fill,
        ),
      );

  Widget _commonParent(BuildContext context, Widget child) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size!),
          border: isBorder ?? false
              ? Border.all(color: ColorConstants.primaryColor)
              : null,
        ),
        child: child,
      );

  Widget _getInitialsView() => Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            name!.getInitials(),
            style: TextStyle(
                color: ColorConstants.secondaryColor,
                fontSize: size! / 3,
                fontWeight: SizeConstants.fontWeightMedium),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          ),
        ),
      );
}
