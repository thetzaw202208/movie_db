import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:movie_db/constant/colors.dart';
import 'package:movie_db/constant/dimens.dart';
import 'package:movie_db/constant/strings.dart';
import 'package:movie_db/data/apply/movie_db_apply.dart';
import 'package:movie_db/data/apply/movie_db_apply_impl.dart';
import 'package:movie_db/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_db/widgets/blur_effect_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant/number_constant.dart';
import '../view_items/home_view_items.dart';
import '../widgets/common_text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieDBApply movieDBApply = MovieDBApplyImpl();
  final controller = PageController(viewportFraction: 1, keepPage: true);
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AdvancedDrawer(
      drawer: Container(),
      backdropColor: kButtonWhiteColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: const CommonTextWidget(text: kAppBarTitle),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: const [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.search_outlined,
                  color: kButtonWhiteColor,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kBannerSizeBoxHeight,
                child: FutureBuilder<List<MovieVO>?>(
                    future: movieDBApply.getNowPlayingMovies(kRequestPageN0),
                    builder: (context, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapShot.hasError) {
                        return const Center(
                          child: CommonTextWidget(text: kConnectionError),
                        );
                      }
                      final listMovieBanner =
                          snapShot.data?.take(kBannerMovieCount).toList();
                      return PageView.builder(
                          controller: controller,
                          itemCount: listMovieBanner?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: width,
                                    height: kBannerSizeBoxHeight,
                                    child: BannerMovieItemView(
                                        movieVO: listMovieBanner?[index]),
                                  ),
                                  const Positioned(
                                      bottom: 0.0,
                                      top: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: BottomBlurEffect()),

                                  ///Movie Title
                                ],
                              ),
                            );
                          });
                    }),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: kBannerMovieCount,
                  effect: const WormEffect(
                      dotColor: kButtonWhiteColor,
                      activeDotColor: kPlayButtonColor,
                      dotHeight: 9,
                      dotWidth: 9,
                      spacing: 10,
                      paintStyle: PaintingStyle.fill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
