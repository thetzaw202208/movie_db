import 'package:flutter/material.dart';

import '../constant/api_constant.dart';
import '../data/vos/movie_vo/movie_vo.dart';

class BannerMovieItemView extends StatelessWidget {
  const BannerMovieItemView({Key? key, required this.movieVO})
      : super(key: key);
  final MovieVO? movieVO;

  @override
  Widget build(BuildContext context) {
    var image = movieVO?.backdropPath ?? '';
    return Image.network(
      '$kPrefixImageLink$image',
      fit: BoxFit.cover,
    );
  }
}
