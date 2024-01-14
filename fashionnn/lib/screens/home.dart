import 'package:fashionnn/data/app_data.dart';
import 'package:fashionnn/model/base_model.dart';
import 'package:fashionnn/model/categories_model.dart';
import 'package:fashionnn/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController(
      initialPage: 2,
      viewportFraction: 0.7,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP TEXT
              FadeInUp(
                delay: Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Find your',
                          style: theme.displayLarge,
                          children: [
                            TextSpan(
                              text: ' Style',
                              style: theme.displayLarge?.copyWith(
                                color: primaryColor,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Be more beautiful with our ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: 'Suggestion',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // CATEGORIES
              FadeInUp(
                delay: Duration(milliseconds: 45),
                child: Container(
                  margin: EdgeInsets.only(top: 7),
                  width: size.width,
                  height: size.height * 0.14,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      CategoriesModel current = categories[index];

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage(current.imageUrl),
                            ),
                            SizedBox(
                              height: size.height * 0.008,
                            ),
                            Text(
                              current.title,
                              style: theme.titleMedium,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // BODY
              BounceInDown(
                duration: Duration(milliseconds: 700),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: size.width,
                  height: size.height * 0.45,
                  child: PageView.builder(
                    controller: _controller,
                    physics: BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    itemBuilder: (context, index) {
                      return view(index, theme, size);
                    },
                  ),
                ),
              ),

              // MOST POPULAR TEXT
              BounceInDown(
                delay: Duration(milliseconds: 650),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most popular',
                        style: theme.displaySmall,
                      ),
                      Text(
                        'See all',
                        style: theme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // MOST POPULAR CONTENT
              FadeInDown(
                delay: Duration(milliseconds: 750),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: size.width,
                  height: size.height * 0.44,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.63,
                    ),
                    itemCount: mainList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      BaseModel current = mainList[index];

                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              width: size.width * 0.5,
                              height: size.height * 0.3,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                image: DecorationImage(
                                  image: AssetImage(current.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color: Color.fromARGB(61, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                current.name,
                                style: theme.displayMedium,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'RM',
                                style: theme.titleSmall?.copyWith(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' ${current.price.toString()}',
                                    style: theme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = 0.0;

        if (_controller.position.haveDimensions) {
          value = index.toDouble() - (_controller.page ?? 0);
          value = (value * 0.04).clamp(-1, 1);
        }

        return Transform.rotate(
          angle: 3.14 * value,
          child: _buildCard(size, mainList[index], theme),
        );
      },
    );
  }

  Padding _buildCard(Size size, BaseModel data, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Column(
        children: [
          // IMAGE
          Container(
            width: size.width * 0.6,
            height: size.height * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: AssetImage(data.imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromARGB(61, 0, 0, 0),
                ),
              ],
            ),
          ),

          // PRODUCT NAME
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              data.name,
              style: theme.displayMedium,
            ),
          ),

          // PRICE
          RichText(
            text: TextSpan(
              text: 'RM',
              style: theme.titleSmall?.copyWith(
                color: primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' ${data.price.toString()}',
                  style: theme.titleSmall?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
