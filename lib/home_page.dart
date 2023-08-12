import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


String sampleImage = "https://images.unsplash.com/photo-1484417894907-623942c8ee29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDZ8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60";

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  isSmallDevice(Size size)
  {
    return size.height < 675;
  }
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size =   MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: const Text("Demo",style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[800],
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            physics:  isSmallDevice(size) ? const AlwaysScrollableScrollPhysics() :
            const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: SizedBox(
                height: isSmallDevice(size) ? size.height + size.height*.2 :   size.height ,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: sampleImage,
                      fit: BoxFit.fill,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height*.35,
                      width: double.infinity,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: Text(
                        "This code will elegantly scrollable on smaller devices, while unscrollable on larger devices.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                      child: TextFormField(
                          onFieldSubmitted: (String value) {
                            _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInBack);
                          },
                          decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 1.0),
                          ),
                        )
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(onPressed: () {},
                        child: Container(
                            width: size.width*.8,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: const Text("login"))),
                    const SizedBox(height: 30,),
                    ElevatedButton(onPressed: () {},
                        child: Container(
                            width: size.width*.8,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: const Text("Sign up"))),
                    const Spacer(flex: 2),
                  ],
                )),

          )
      ),
    );
  }
}







