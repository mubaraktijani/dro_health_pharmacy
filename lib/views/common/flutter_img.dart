import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:velocity_x/velocity_x.dart';

class FlutterIMG extends StatelessWidget {

	final String path;
	final BoxFit fit;
	final double height;
	final double width;
	final double borderRadius;

	FlutterIMG(this.path, {
		this.fit, 
		this.height, 
		this.width, 
		this.borderRadius
	});

	@override
	Widget build(BuildContext context) => ClipRRect(
		borderRadius: (this.borderRadius != null)
			? BorderRadius.circular(this.borderRadius)
			: BorderRadius.zero,
		child: (_isNetworkImage)
			? CachedNetworkImage(
				imageUrl: this.path,
				fit: this.fit,
				alignment: Alignment.topCenter,
				placeholder: (_, __) => _shimmer(
					enabled: true,
					height: this.height
				),
				errorWidget: (_, __, ___) => _shimmer(
					enabled: false,
					height: this.height
				)
			)
			.h(this.height)
			.w(this.width)
			: Image.asset(
				this.path,
				fit: this.fit
			)
			.h(this.height)
			.w(this.width)
	);

	bool get _isNetworkImage => (
		this.path != null && 
		(this.path.contains('//') || this.path.contains('http'))
	);

	Widget _shimmer({bool enabled: true, double height}) => Shimmer.fromColors(
		baseColor: Colors.grey[200],
		highlightColor: Colors.grey[50],
		enabled: enabled,
		direction: ShimmerDirection.ttb,
		child: Container(
			color: Colors.grey
		)
		.h(this.height)
		.w(this.width)
	);
}