import 'package:flutter/material.dart';
import 'package:moniepoint_test/utils/app_colors.dart';
import '../widget/custom_text.dart';
import '../widget/text_feild.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _iconOpacityAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _widthAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 100.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(100.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 100.0, end: 50.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(_animationController);

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.5),
      ),
    );

    _iconOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.85, 1.0),
      ),
    );

    // Initialize _opacityAnimation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0), // Customize this curve as needed
      ),
    );
    // Scale animation from 0.5 (small) to 1.0 (full size)
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 100.0, right: 20.0, left: 40.0),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showPopupMenu();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      child: const Icon(
                        Icons.layers_outlined,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          child: const Icon(
                            Icons.point_of_sale_rounded,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              color: AppColors.white,
                            ),
                            CustomText(
                              weight: FontWeight.w400,
                              size: 15,
                              color: AppColors.white,
                              title: "List of variants",
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/g1DgT.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Stack(
              children: [
                Positioned(
                  top: 20, // Adjust position as needed
                  left: 20,
                  right: 20,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: CustomSearchBar(
                        controller: TextEditingController(),
                        onSettingsPressed: () {},
                      ),
                    ),
                  ),
                ),
                // Scattered AnimatedContainers
                Positioned(
                  left: 90,
                  top: 150,
                  child: _buildAnimatedContainer(),
                ),
                Positioned(
                  left: 120,
                  top: 210,
                  child: _buildAnimatedContainer(),
                ),
                Positioned(
                  left: 300,
                  top: 250,
                  child: _buildAnimatedContainer(),
                ),

                Positioned(
                  left: 80,
                  bottom: 450,
                  child: _buildAnimatedContainer(),
                ),
                Positioned(
                  left: 300,
                  top: 400,
                  child: _buildAnimatedContainer(),
                ),
                Positioned(
                  left: 250,
                  bottom: 330,
                  child: _buildAnimatedContainer(),
                ),
              ],
            )),
      ),
    );
  }

  // Animated container with text that fades in and icon that shows when resting
  Widget _buildAnimatedContainer() {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return Container(
          width: _widthAnimation
              .value, // Animate width from 0 to 100, then back to 50
          height: 50, // Fixed height
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fade in/out the text during rest at 100, fade out before shrinking starts
                _widthAnimation.value > 50
                    ? FadeTransition(
                        opacity: _textOpacityAnimation,
                        child: const Text(
                          "10.3mnP",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // Fixed size, no resizing
                          ),
                        ),
                      )
                    :
                    // Fade in the icon at resting width of 50
                    FadeTransition(
                        opacity: _iconOpacityAnimation,
                        child: const Icon(
                          Icons.houseboat,
                          color: AppColors.white,
                          size: 20, // Icon size at resting state
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(
          20, 540, 100, 100), // Adjust the position accordingly
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.check_box_outlined, color: Colors.grey[600]),
              const SizedBox(width: 10),
              Text("Cosy areas", style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined, color: Colors.orange),
              SizedBox(width: 10),
              Text("Price", style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.delete_outline, color: Colors.grey[600]),
              const SizedBox(width: 10),
              Text("Infrastructure", style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Row(
            children: [
              Icon(Icons.layers_outlined, color: Colors.grey[600]),
              const SizedBox(width: 10),
              Text("Without any layer",
                  style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      menuPadding: const EdgeInsets.all(5),
      color: AppColors.lighgrey,
      elevation: 8,
    ).then((value) {
      if (value != null) {
        setState(() {
          switch (value) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
          }
        });
      }
    });
  }
}
