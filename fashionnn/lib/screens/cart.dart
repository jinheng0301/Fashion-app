import 'package:animate_do/animate_do.dart';
import 'package:fashionnn/data/app_data.dart';
import 'package:fashionnn/main_wrapper.dart';
import 'package:fashionnn/model/base_model.dart';
import 'package:fashionnn/utils/constants.dart';
import 'package:fashionnn/widgets/reusable_button.dart';
import 'package:fashionnn/widgets/reusable_row_for_cart.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // delete current selected item from list
  void onDelete(BaseModel data) {
    setState(() {
      if (itemsOnCart.length == 1) {
        itemsOnCart.clear();
      } else {
        itemsOnCart.removeWhere(
          (element) => element.id == data.id,
        );
      }
    });
  }

  // CALCULATE TOTAL PRICE
  double calculateTotalPrice() {
    double total = 0.0;

    if (itemsOnCart.isEmpty) {
      total = 0.0;
    } else {
      for (BaseModel data in itemsOnCart) {
        total += data.price * data.value;
      }
    }

    return total;
  }

  // CALCULATE SHIPPING
  double calculateShipping() {
    double shipping = 0.0;

    if (itemsOnCart.isEmpty) {
      shipping = 0.0;
    } else if (itemsOnCart.length <= 4) {
      shipping = 25.99;
    } else {
      shipping = 88.99;
    }

    return shipping;
  }

  // CALCULATE SUBTOTAL
  double calculateSubTotal() {
    double subTotal = 0;

    if (itemsOnCart.isNotEmpty) {
      subTotal = 0;
    } else {
      for (BaseModel data in itemsOnCart) {
        subTotal += data.price.round();
        subTotal -= 160;
      }
    }

    return subTotal < 0 ? 0 : subTotal;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LineIcons.user,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.6,
              child: itemsOnCart.isNotEmpty
                  // list is not empty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: itemsOnCart.length,
                      itemBuilder: (context, index) {
                        var current = itemsOnCart[index];

                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index + 80),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: size.width,
                            height: size.height * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // PRODUCT IMAGE
                                Container(
                                  margin: EdgeInsets.all(5),
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(61, 0, 0, 0),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(current.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: size.height * 0.01,
                                ),

                                // PRODUCT DETAILS
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.52,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              current.name,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                onDelete(current);
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'USD ',
                                          style: textTheme.titleSmall?.copyWith(
                                            fontSize: 22,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: current.price.toString(),
                                              style: textTheme.titleSmall
                                                  ?.copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.04,
                                      ),
                                      Text(
                                        'Size = ${sizes[4]}',
                                        style: textTheme.titleSmall?.copyWith(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: size.height * 0.03,
                                        ),
                                        width: size.width * 0.4,
                                        height: size.height * 0.04,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(4),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (current.value > 1) {
                                                      current.value--;
                                                    } else {
                                                      onDelete(current);
                                                      current.value = 1;
                                                    }
                                                  });
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.02,
                                              ),
                                              child: Text(
                                                current.value.toString(),
                                                style: textTheme.titleSmall
                                                    ?.copyWith(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(4),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    current.value >= 0
                                                        ? current.value++
                                                        : null;
                                                  });
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Colors.grey,
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
                          ),
                        );
                      },
                    )
                  : // list is empty
                  Column(
                      children: [
                        FadeInUp(
                          delay: Duration(milliseconds: 200),
                          child: Image(
                            image: AssetImage('images/empty.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        FadeInUp(
                          delay: Duration(milliseconds: 250),
                          child: Text(
                            'Your shopping cart is empty right now.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: Duration(milliseconds: 300),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainWrapper(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.shopping_bag_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            // PRODUCT PRICES
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: size.width,
                height: size.height * 0.46,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 350),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Promo/Student Code or Vourchers",
                              style: textTheme.displaySmall
                                  ?.copyWith(fontSize: 16),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 400),
                        child: ReusableRowForCart(
                          text: 'Sub Total: ',
                          price: calculateSubTotal(),
                        ),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 400),
                        child: ReusableRowForCart(
                          text: 'Shipping: ',
                          price: calculateShipping(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(),
                      ),
                      FadeInUp(
                        delay: Duration(milliseconds: 400),
                        child: ReusableRowForCart(
                          text: 'Total: ',
                          price: calculateTotalPrice(),
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 550),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: ReusableButton(
                            text: "Checkout",
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cart(),
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
            ),
          ],
        ),
      ),
    );
  }
}
