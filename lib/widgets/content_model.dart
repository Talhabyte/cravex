class Unboardingcontent {
  String title;
  String subtitle;
  String image;
  Unboardingcontent({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<Unboardingcontent> content = [
  Unboardingcontent(
    title: "Select From Our Best Menu",
    subtitle: "Pick your food from our menu more than 35 items",
    image: "assets/Images/onboardingone.png",
  ),
  Unboardingcontent(
    title: "Easy And Online Payment",
    subtitle: "You can pay cash on delivery and Card payment is available",
    image: "assets/Images/onboardingthree.png",
  ),

  Unboardingcontent(
    title: "Quick Delivery At Your Doorstep",
    subtitle: "Delivery  at your Doorstep",
    image: "assets/Images/onboardingtwo.png",
  ),
];
