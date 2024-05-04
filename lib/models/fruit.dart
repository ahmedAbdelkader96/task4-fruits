class Fruit {
  const Fruit({
    this.name,
    this.description,
    this.heroName,
    this.pathImage,
    this.rawColor,
  });

  final String? name;
  final String? heroName;
  final String? description;
  final String? pathImage;
  final int? rawColor;

  static const fruits = [
    Fruit(
        heroName: 'Grapes',
        name: 'ahmed market',
        description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        pathImage: 'assets/grapes.png',
        rawColor: 0xffA41209),
    Fruit(
        heroName: 'kiwi',
        name: 'ahmed market',
        description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        pathImage: 'assets/kiwi.png',
        rawColor: 0xffB3790F),
    Fruit(
        heroName: 'Orange',
        name: 'ahmed market',
        description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        pathImage: 'assets/orange.png',
        rawColor: 0xff3E4953),
    Fruit(
        heroName: 'apple',
        name: 'ahmed market',
        description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        pathImage: 'assets/appl.png',
        rawColor: 0xff98142B),
    Fruit(
        heroName: 'Peach',
        name: 'ahmed market',
        description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
            "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        pathImage: 'assets/peach.png',
        rawColor: 0xff011535),

  ];
}

