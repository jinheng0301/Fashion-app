import 'package:animate_do/animate_do.dart';
import 'package:fashionnn/data/app_data.dart';
import 'package:fashionnn/methods/add_to_cart.dart';
import 'package:fashionnn/model/base_model.dart';
import 'package:fashionnn/screens/details.dart';
import 'package:fashionnn/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TextEditingController();
    itemsOnSearch = mainList;
    super.initState();
  }

  void onSearchFunc(String search) {
    setState(() {
      itemsOnSearch = mainList
          .where((element) => element.name.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              // SEARCH TEXT FIELD
              FadeInLeft(
                delay: Duration(milliseconds: 50),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.07,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        onSearchFunc(value);
                      },
                      style: textTheme.displaySmall?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                          },
                          icon: Icon(Icons.close),
                        ),
                        hintText: 'e.g. Casual Jeans',
                        hintStyle: textTheme.displaySmall?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.01,
              ),

              Expanded(
                child: FadeInRight(
                  delay: Duration(milliseconds: 50),
                  child: itemsOnSearch.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.63,
                          ),
                          itemCount: itemsOnSearch.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            BaseModel current = itemsOnSearch[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details(
                                      data: mainList[index],
                                      isCameFromMostPopularPart: true,
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: size.height * 0.02,
                                    left: size.width * 0.01,
                                    right: size.width * 0.01,
                                    child: Hero(
                                      tag: current.imageUrl,
                                      child: Container(
                                        width: size.width * 0.5,
                                        height: size.height * 0.25,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          image: DecorationImage(
                                            image: AssetImage(current.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                              color:
                                                  Color.fromARGB(61, 0, 0, 0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: size.height * 0.04,
                                    child: Text(
                                      current.name,
                                      style: textTheme.displayMedium,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: size.height * 0.01,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'USD',
                                        style: textTheme.titleSmall?.copyWith(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                ' ${current.price.toString()}',
                                            style:
                                                textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height * 0.01,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: primaryColor,
                                      child: IconButton(
                                        onPressed: () {
                                          AddToCart.addToCart(current, context);
                                        },
                                        icon: Icon(
                                          LineIcons.shoppingCart,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : FadeInRightBig(
                          delay: Duration(milliseconds: 50),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage('images/search_fail.png'),
                              ),
                              SizedBox(
                                height: size.height * 0.0,
                              ),
                              Text(
                                'No result found',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
