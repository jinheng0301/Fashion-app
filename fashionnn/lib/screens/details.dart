import 'package:animate_do/animate_do.dart';
import 'package:fashionnn/model/base_model.dart';
import 'package:fashionnn/utils/constants.dart';
import 'package:fashionnn/widgets/reusable_button.dart';
import 'package:fashionnn/widgets/reusable_text.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  late final BaseModel data;
  late final bool isCameFromMostPopularPart;

  Details({
    required this.data,
    required this.isCameFromMostPopularPart,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize = 3;
  int selectedColor = 2;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    BaseModel current = widget.data;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline),
            color: Colors.white,
          ),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRODUCT IMAGE
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Stack(
                children: [
                  // TOP IMAGE
                  Hero(
                    tag: widget.isCameFromMostPopularPart
                        ? current.imageUrl
                        : current.id,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(current.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.12,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PRODUCT INFO
            FadeInDown(
              delay: Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            current.name,
                            style: textTheme.displaySmall?.copyWith(
                              fontSize: 23,
                            ),
                          ),
                          ReusableTextForDetails(
                            text: current.price.toString(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            current.star.toString(),
                            style: textTheme.headlineSmall,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "(${current.review.toString()}K+ review)",
                            style: textTheme.headlineSmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SELECT SIZE TEXT
            FadeIn(
              delay: const Duration(milliseconds: 700),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 18.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Select Size',
                  style: textTheme.displaySmall,
                ),
              ),
            ),

            // SIZE
            FadeInRight(
              delay: Duration(milliseconds: 500),
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.08,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: ((context, index) {
                    var current = sizes[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = index;
                        });
                      },
                      child: AnimatedContainer(
                        margin: EdgeInsets.all(10),
                        duration: Duration(milliseconds: 200),
                        width: size.width * 0.12,
                        decoration: BoxDecoration(
                          color: selectedSize == index
                              ? primaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            current,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: selectedSize == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // SELECT COLOR
            FadeIn(
              delay: const Duration(milliseconds: 700),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 18.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Select Color',
                  style: textTheme.displaySmall,
                ),
              ),
            ),

            // COLOR
            FadeInRight(
              delay: Duration(milliseconds: 500),
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.08,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: ((context, index) {
                    var current = colors[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: AnimatedContainer(
                        margin: EdgeInsets.all(10),
                        duration: Duration(milliseconds: 100),
                        width: size.width * 0.12,
                        decoration: BoxDecoration(
                          color: current,
                          border: Border.all(
                            color: selectedColor == index
                                ? primaryColor
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // ADD TO CART
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: ReusableButton(
                  onTap: () {
                    print('add to cart');
                  },
                  text: 'Add to cart',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
