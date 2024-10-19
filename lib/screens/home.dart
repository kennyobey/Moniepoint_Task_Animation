import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:moniepoint_test/utils/app_colors.dart';
import '../widget/custom_text.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage>
    with SingleTickerProviderStateMixin {
  bool _isAnimating = false; // Removed final and allow it to change
  final double _slidePosition = -300; // Start position (off-screen)
  bool _isSliding = false;
  double _size = 100.0;
  late AnimationController _controller;
  int _counterValue = 0;
  int _counterValue2 = 0;
  final int _maxValue = 1034;
  final int _maxValue2 = 2212;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addListener(() {
        setState(() {
          _size = 50 + 140 * _controller.value;
          _counterValue = (_maxValue * _controller.value).toInt();
          _counterValue2 = (_maxValue2 * _controller.value).toInt();
          if (_controller.value >= 1.0) {
            _controller.stop(); // Stop the animation
          }
        });
      });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSliding = true; // Start sliding
      });
    });
    _controller.forward();

    // Trigger the animation to start after a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isAnimating = true;
      });
      // Reverse the animation after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isAnimating = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculateFontSize(double size) {
    return size / 5;
  }

  double _calculateFontSize2(double size) {
    return size / 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.containerWhite,
          elevation: 0,
          centerTitle: false,
          title: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-200 * (1 - _controller.value), 0),
                child: Container(
                  width: 190,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                    opacity: _controller.value > 0.8
                        ? (_controller.value - 0.8) * 5
                        : 0,
                    child: const Row(
                      children: [
                        Icon(
                          size: 20,
                          Icons.place,
                          color: AppColors.appBarTexColor,
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          weight: FontWeight.w400,
                          size: 16,
                          color: AppColors.appBarTexColor,
                          title: "Saint Petersburg",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double size = 20 + (_controller.value * 20); // 20 to 40
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInCubic,
                  width: size,
                  height: size,
                  child: CircleAvatar(
                    radius: size / 2, // Adjust the radius based on the size
                    backgroundImage: const AssetImage(
                        "assets/images/img_profile_pics_2.png"),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
            width: double.infinity,
            height: 900,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  AppColors.lightRrange, // Light orange
                  AppColors.white, // Light orange
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      _buildAnimatedSection1(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildSection2(),
                      const SizedBox(
                        height: 700, // Provide space for the overlap
                      ),
                    ],
                  ),
                  AnimatedPositioned(
                    duration: const Duration(seconds: 4),
                    curve: Curves.easeInOut,
                    top: _isAnimating
                        ? 100 // Overlap position
                        : 370, // Final position after returning
                    left: 0,
                    right: 0,
                    child: _buildSectionWithButton3(),
                  ),
                ],
              ),
            )));
  }

  Widget _buildAnimatedSection1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 100),
            child: const CustomText(
              weight: FontWeight.w400,
              size: 16,
              color: AppColors.appBarTexColor,
              title: "Hi Marina",
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSlide(
            offset: _controller.value >= 0.4
                ? const Offset(0, 0)
                : const Offset(0, 1),
            duration: const Duration(milliseconds: 800),
            child: AnimatedOpacity(
              opacity: _controller.value >= 0.4 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const CustomText(
                weight: FontWeight.w400,
                size: 26,
                color: AppColors.black,
                title: "let's select your \nperfect place",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          width: _size,
          height: _size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.orange,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                weight: FontWeight.w400,
                size: _calculateFontSize2(_size),
                color: AppColors.white,
                title: "Buy",
              ),
              Column(
                children: [
                  Text(
                    _counterValue.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _calculateFontSize(_size),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomText(
                    weight: FontWeight.w400,
                    size: _calculateFontSize2(_size),
                    color: AppColors.white,
                    title: "offers",
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
            color: AppColors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                weight: FontWeight.w400,
                size: _calculateFontSize2(_size),
                color: AppColors.appBarTexColor,
                title: "Rent",
              ),
              Column(
                children: [
                  Text(
                    _counterValue2.toString(),
                    style: TextStyle(
                      color: AppColors.appBarTexColor,
                      fontSize: _calculateFontSize(_size),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomText(
                    weight: FontWeight.w400,
                    size: _calculateFontSize2(_size),
                    color: AppColors.appBarTexColor,
                    title: "offers",
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionWithButton3() {
    return SingleChildScrollView(
      child: SlideInUp(
        curve: Curves.linear,
        from: 600, // Adjust starting position for higher entry
        duration: const Duration(seconds: 2),
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(
              0, _isSliding ? 0 : 50, 0), // Start higher and move down
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 8),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/IMG_3076.PNG"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.orange,
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(seconds: 3),
                          curve: Curves.easeInOut,
                          left: _isSliding ? 0 : _slidePosition,
                          bottom: 10,
                          width: MediaQuery.of(context).size.width - 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  AppColors.stackButtonColor.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                const CustomText(
                                  weight: FontWeight.w400,
                                  size: 18,
                                  color: AppColors.black,
                                  title: "GladKova St., 25",
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.black,
                                      size: 10,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.white, width: 8),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/IMG_3073.JPG"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.orange,
                          ),
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(seconds: 4),
                                curve: Curves.easeInOut,
                                left: _isSliding ? 0 : _slidePosition,
                                bottom: 10,
                                width: MediaQuery.of(context).size.width - 260,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.stackButtonColor
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomText(
                                        weight: FontWeight.w400,
                                        size: 18,
                                        color: AppColors.black,
                                        title: "Gubina St., 11",
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.black,
                                            size: 10,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.white, width: 8),
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/IMG_3078.JPG"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.orange,
                              ),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(seconds: 4),
                                    curve: Curves.easeInOut,
                                    left: _isSliding ? 0 : _slidePosition,
                                    bottom: 10,
                                    width:
                                        MediaQuery.of(context).size.width - 260,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.stackButtonColor
                                            .withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(
                                            weight: FontWeight.w400,
                                            size: 16,
                                            color: AppColors.black,
                                            title: "Trevoleva St., 43",
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.white,
                                              ),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black,
                                                size: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.white, width: 8),
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/IMG_3075.JPG"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.orange,
                              ),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(seconds: 4),
                                    curve: Curves.easeInOut,
                                    left: _isSliding ? 0 : _slidePosition,
                                    bottom: 10,
                                    width:
                                        MediaQuery.of(context).size.width - 260,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.stackButtonColor
                                            .withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomText(
                                            weight: FontWeight.w400,
                                            size: 16,
                                            color: AppColors.black,
                                            title: "Sedova St., 22",
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.white,
                                              ),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.black,
                                                size: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
