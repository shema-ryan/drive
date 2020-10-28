class Car {
  String brand;
  String model;
  double price;
  String condition;
  List<String> images;
  String fuelConsumption;

  Car({
    this.brand,
    this.model,
    this.price,
    this.condition,
    this.images,
    this.fuelConsumption,
  });
}

class Dealer {
  String name;
  int offers;
  String image;

  Dealer({this.name, this.offers, this.image});
}

class Data {
  static List<Car> getCarList = [
    Car(
      brand: "Land Rover",
      model: "Discovery",
      price: 2580,
      condition: "Weekly",
      fuelConsumption: "5.5l",
      images: [
        "assets/images/land_rover_0.png",
        "assets/images/land_rover_1.png",
        "assets/images/land_rover_2.png",
      ],
    ),
    Car(
      brand: "Alfa Romeo",
      model: "C4",
      price: 3580,
      condition: "Monthly",
      images: [
        "assets/images/alfa_romeo_c4_0.png",
      ],
      fuelConsumption: '3.6l',
    ),
    Car(
      brand: "Nissan",
      model: "GTR",
      price: 1100,
      condition: "Daily",
      images: [
        "assets/images/nissan_gtr_0.png",
        "assets/images/nissan_gtr_1.png",
        "assets/images/nissan_gtr_2.png",
        "assets/images/nissan_gtr_3.png",
      ],
      fuelConsumption: '4.2l',
    ),
    Car(
      brand: "Acura",
      model: "MDX 2020",
      price: 2200,
      condition: "Monthly",
      images: [
        "assets/images/acura_0.png",
        "assets/images/acura_1.png",
        "assets/images/acura_2.png",
      ],
      fuelConsumption: '3.5l',
    ),
    Car(
        brand: "Chevrolet",
        model: "Camaro",
        price: 3400,
        condition: "Weekly",
        images: [
          "assets/images/camaro_0.png",
          "assets/images/camaro_1.png",
          "assets/images/camaro_2.png",
        ],
        fuelConsumption: '5.02l'),
    Car(
      brand: "Ferrari",
      model: "Spider 488",
      price: 4200,
      condition: "Weekly",
      images: [
        "assets/images/ferrari_spider_488_0.png",
        "assets/images/ferrari_spider_488_1.png",
        "assets/images/ferrari_spider_488_2.png",
        "assets/images/ferrari_spider_488_3.png",
        "assets/images/ferrari_spider_488_4.png",
      ],
      fuelConsumption: '6.5l',
    ),
    Car(
      brand: "Ford",
      model: "Focus",
      price: 2300,
      condition: "Weekly",
      images: [
        "assets/images/ford_0.png",
        "assets/images/ford_1.png",
      ],
      fuelConsumption: '5.2l',
    ),
    Car(
      brand: "Fiat",
      model: "500x",
      price: 1450,
      condition: "Weekly",
      images: [
        "assets/images/fiat_0.png",
        "assets/images/fiat_1.png",
      ],
      fuelConsumption: '4.9l',
    ),
    Car(
      brand: "Honda",
      model: "Civic",
      price: 900,
      condition: "Daily",
      images: [
        "assets/images/honda_0.png",
      ],
      fuelConsumption: '3.2l',
    ),
    Car(
      brand: "Citroen",
      model: "Picasso",
      price: 1200,
      condition: "Monthly",
      images: [
        "assets/images/citroen_0.png",
        "assets/images/citroen_1.png",
        "assets/images/citroen_2.png",
      ],
      fuelConsumption: '2.5l',
    ),
  ];
  static List<Dealer> getDealerList = [
    Dealer(
      name: "Hertz",
      offers: 174,
      image: "assets/images/hertz.png",
    ),
    Dealer(
      name: "Avis",
      offers: 126,
      image: "assets/images/avis.png",
    ),
    Dealer(
      name: "Tesla",
      offers: 89,
      image: "assets/images/tesla.jpg",
    ),
  ];
}
