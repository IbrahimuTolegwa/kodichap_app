import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/calouselslider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final List<Map<String, dynamic>> carouselData = [
    {
      "imageUrl": 'https://source.unsplash.com/random', // Using a random Unsplash image
      "price": "TSH 100,000/=",
      "rooms": "Variety",
      "location": "Makongolosi, chunya, Mbeya"
    },
    {
      "imageUrl": 'https://via.placeholder.com/600x400', // A different placeholder size
      "price": "TSH 200,000/=",
      "rooms": "N/A",
      "location": "Chunya, Mbeya"
    },
    {
      "imageUrl": 'https://source.unsplash.com/daily', // Unsplash photo of the day
      "price": "TSH 200,000/=",
      "rooms": "Inspiring",
      "location": "Mbeya Mjini"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text(
          'KODICHAP', style: TextStyle(color: Color(0xFF885A00), fontWeight: FontWeight.bold, fontSize: 35),),
        centerTitle: true,
        actions: [
            IconButton(
            icon: Icon(Icons.filter_alt_outlined),
      onPressed: () async { // Make it async to wait for the result
        final filterResult = await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context){
            return filterBottomSheet();
          },
        );

        // Process the filterResult
        if (filterResult != null) {
          // Assuming filterResult is a Map as returned from the bottom sheet
          double? minPrice = filterResult['minPrice'];
          double? maxPrice = filterResult['maxPrice'];
          String locationFilter = filterResult['location'];

          // Implement filtering logic here
          List<Map<String, dynamic>> filteredData = carouselData.where((item) {
            bool matchesPrice = true;
            if (minPrice != null || maxPrice != null) {
              // You'll need to parse the price string from your data
              // This is a basic example and assumes the price format is consistent
              double itemPrice = double.tryParse(item['price'].toString().replaceAll('TSH', '').replaceAll(',', '').replaceAll('/=', '').trim()) ?? 0.0;

              if (minPrice != null && itemPrice < minPrice) {
                matchesPrice = false;
              }
              if (maxPrice != null && itemPrice > maxPrice) {
                matchesPrice = false;
              }
            }

            bool matchesLocation = true;
            if (locationFilter != 'all location') {
              // You might want a more robust location matching logic
              matchesLocation = item['location'].toString().toLowerCase().contains(locationFilter.toLowerCase());
            }

            return matchesPrice && matchesLocation;
          }).toList();

          // Update the state to display filtered data
          // You'll need a state variable to hold the currently displayed data
          // For example: List<Map<String, dynamic>> displayedData = carouselData;
          // setState(() {
          //   displayedData = filteredData;
          // });
          // Then use displayedData in your ListView.builder
        }
      },
    ),
          IconButton(
              icon: Icon(Icons.language_outlined, size: 25,),
              onPressed: (){},)
        ],
        leading: IconButton(
            icon: Icon(Icons.person_2_rounded),
            onPressed: (){},),),
        body: Center(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 300,
                  viewportFraction: 0.75,
                  aspectRatio: 16/9,
                ),
                items: carouselData.map((item){
                  return imageCarousel(
                    imageUrl: item['imageUrl'],
                     title: item['price'],
                      rooms: item['rooms'],);
                }).toList(),),

              Text("items"),

              Expanded(
                child: ListView.builder(
                  itemCount: carouselData.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              )
                            ]
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  'https://source.unsplash.com/random',
                                  height: 150,
                                  width: 150,
                              )),
                            ),

                            SizedBox(
                              width: 8,
                            ),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(carouselData[index]['price'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Text("VYOO"),
                                      Icon(Icons.bathtub_outlined, size: 20,),
                                      Text("1"),
                                      SizedBox(width: 20,),
                                      Text("VYUMBA"),
                                      Icon(Icons.meeting_room_rounded, size: 20,),
                                      Text("3"),
                                    ],
                                  ),

                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      SizedBox(width: 10,),
                                      Expanded(child: Text(carouselData[index]['location'])),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      );
                    }
                ),
              )
            ],
          )));
       }
}

class filterBottomSheet extends StatefulWidget {
  const filterBottomSheet({super.key});

  @override
  State<filterBottomSheet> createState() => _filterBottomSheetState();
}

class _filterBottomSheetState extends State<filterBottomSheet> {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  String selectedLocation = 'all Location';
  
  final List<String> locations = [
    'all location',
    'Mbeya',
    'Dodoma',
    'Arusha',
    'Dar es salaam'
  ];

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 4, width: 40, color: Colors.brown,margin: EdgeInsets.only(bottom: 16),),),
            Text('CHAGUA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 16,),
            
            //price filter
            Text('BEI'),
            Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Kuanzia',
                        border: OutlineInputBorder(),
                      ),
                    )),
                
                SizedBox(width: 10,),

                Expanded(
                    child: TextField(
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Hadi',
                        border: OutlineInputBorder(),
                      ),
                    )),
              ],
            ),

            SizedBox(height: 16,),

            Text('MAHALI'),
            DropdownButtonFormField<String>(
                onChanged: (value){
                  setState(() {
                    selectedLocation  = value!;
                  });
                },
                items: locations.map((location){
                  return DropdownMenuItem(
                    child: Text(location),
                    value: location,
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

            SizedBox(height: 15,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                    ),
                    onPressed: (){
                      double? minPrice = double.tryParse(minPriceController.text);
                      double? maxPrice = double.tryParse(maxPriceController.text);
                      String locationFilter = selectedLocation;

                      Navigator.pop(context, {
                        'minPrice': minPrice,
                        'maxPrice': maxPrice,
                        'locationFilter': locationFilter,
                      });

                    },
                    child: Text('MALIZA', style: TextStyle(color: Colors.white),)),
              ),

            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}

