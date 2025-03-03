import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:taxi_booking/widgets/color.dart';
import '../SearchProductDelegate.dart';
import '../Details.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _selectedIndex = 0;
  bool _isLoading = true;

  final List<String> _categories = [
    'All',
    'Popular',
    'New',
    'Classic',
    'Special',
  ];

  List<Map<String, String>> flavors = [
    {
      'name': 'Pistachio Chocolate Vanilla',
      'image': 'assets/ice cream.png',
      'price': 'Rp 20.000',
      'category': 'Popular',
    },
    {
      'name': 'Cherry Strawberry',
      'image': 'assets/ice_cream_pink.png',
      'price': 'Rp 20.000',
      'category': 'New',
    },
    {
      'name': 'Double Choc Hazelnut',
      'image': 'assets/ice_cream_brown.png',
      'price': 'Rp 20.000',
      'category': 'Classic',
    },
    {
      'name': 'Mint Chip Symphony',
      'image': 'assets/ice cream.png',
      'price': 'Rp 22.000',
      'category': 'Special',
    },
    {
      'name': 'Mango Tango Sorbet',
      'image': 'assets/ice_cream_pink.png',
      'price': 'Rp 21.000',
      'category': 'New',
    },
    {
      'name': 'Cookies & Cream Dream',
      'image': 'assets/ice_cream_brown.png',
      'price': 'Rp 23.000',
      'category': 'Popular',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Simulate loading data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToDetails(String name, String image, String price) {
    // Adding a hero animation
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                FadeTransition(opacity: animation, child: Details()),
        settings: RouteSettings(
          arguments: {'name': name, 'image': image, 'price': price},
        ),
      ),
    );
  }

  void navigateToProductPage() {
    showSearch(context: context, delegate: SearchProductDelegate());
  }

  List<Map<String, String>> getFilteredIceCreams() {
    if (_selectedIndex == 0) {
      return flavors;
    } else {
      return flavors
          .where((flavor) => flavor['category'] == _categories[_selectedIndex])
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredFlavors = getFilteredIceCreams();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'ice cream',
              textStyle: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              colors: [
                MyColor.primary,
                Colors.purple,
                Colors.blue,
                MyColor.primary,
              ],
              speed: const Duration(milliseconds: 1500),
            ),
          ],
          isRepeatingAnimation: true,
          totalRepeatCount: 3,
        ),
        centerTitle: true,
        leading: Hero(
          tag: 'profile_icon',
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Adding a bounce animation when pressed
              ScaleTransition(
                scale: _scaleAnimation,
                child: const Icon(Icons.shopping_cart),
              );

              try {
                Navigator.of(context).pushNamed('/summary');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error opening cart: $e')),
                );
              }
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(MyColor.primary),
                ),
              )
              : AnimationLimiter(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 600),
                        childAnimationBuilder:
                            (widget) => SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(child: widget),
                            ),
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "mau nyari apa....",
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                  ),
                                  onTap: navigateToProductPage,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Static notification icon (no animation)
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.notifications_outlined,
                                      size: 28,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('No new notifications'),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.black87,
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Banner without effects
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Special promo activated! Get 10% off!',
                                  ),
                                  backgroundColor: MyColor.primary,
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'promo_banner',
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    "assets/banner.jpeg",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 150,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Text("Image not found"),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Category filter horizontal scroll
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          _selectedIndex == index
                                              ? MyColor.primary
                                              : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _categories[index],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              _selectedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedIndex == 0
                                    ? "Most Popular"
                                    : _categories[_selectedIndex],
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(
                                  Icons.sort,
                                  size: 16,
                                  color: MyColor.primary,
                                ),
                                label: Text(
                                  "Sort",
                                  style: GoogleFonts.poppins(
                                    color: MyColor.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  // Show bottom sheet for sorting options
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder:
                                        (context) => Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Sort By",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.arrow_upward,
                                                ),
                                                title: const Text(
                                                  "Price: Low to High",
                                                ),
                                                onTap:
                                                    () =>
                                                        Navigator.pop(context),
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                  Icons.arrow_downward,
                                                ),
                                                title: const Text(
                                                  "Price: High to Low",
                                                ),
                                                onTap:
                                                    () =>
                                                        Navigator.pop(context),
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons.star),
                                                title: const Text("Popularity"),
                                                onTap:
                                                    () =>
                                                        Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                          // Using AnimationLimiter for staggered animations in the list
                          AnimationLimiter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredFlavors.length,
                              itemBuilder: (context, index) {
                                String name = filteredFlavors[index]['name']!;
                                String price = filteredFlavors[index]['price']!;
                                String image = filteredFlavors[index]['image']!;

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap:
                                            () => navigateToDetails(
                                              name,
                                              image,
                                              price,
                                            ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Card(
                                              elevation: 0,
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    // Image with hero animation
                                                    Hero(
                                                      tag: 'ice_cream_$index',
                                                      child: Container(
                                                        width: 70,
                                                        height: 70,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                    0.2,
                                                                  ),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          child: Image.asset(
                                                            image,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) {
                                                              return Container(
                                                                width: 70,
                                                                height: 70,
                                                                color:
                                                                    Colors
                                                                        .grey[300],
                                                                child: const Icon(
                                                                  Icons
                                                                      .image_not_supported,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            name,
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            "Refreshing delicate taste and melt-in-your-mouth texture.",
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors
                                                                      .grey
                                                                      .shade600,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const SizedBox(
                                                            height: 6,
                                                          ),
                                                          Row(
                                                            children: [
                                                              // Rating stars
                                                              ...List.generate(
                                                                5,
                                                                (i) => Icon(
                                                                  i < 4
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_border,
                                                                  color:
                                                                      Colors
                                                                          .amber,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "4.0",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          price,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    MyColor
                                                                        .primary,
                                                              ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:
                                                                Colors
                                                                    .pink
                                                                    .shade50,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.all(
                                                                6,
                                                              ),
                                                          child: const Icon(
                                                            Icons.add,
                                                            color:
                                                                MyColor.primary,
                                                            size: 20,
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
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      floatingActionButton: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: FloatingActionButton(
              backgroundColor: MyColor.primary,
              onPressed: () {
                // Show a quick order bottom sheet
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder:
                      (context) => Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Quick Order",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.75,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                  itemCount: flavors.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                  child: Image.asset(
                                                    flavors[index]['image']!,
                                                    height: 120,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        flavors[index]['name']!,
                                                        style:
                                                            GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            flavors[index]['price']!,
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color:
                                                                      Colors
                                                                          .pink,
                                                                ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  5,
                                                                ),
                                                            decoration:
                                                                BoxDecoration(
                                                                  color:
                                                                      Colors
                                                                          .pink,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        5,
                                                                      ),
                                                                ),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
              child: const Icon(Icons.ice_skating, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
