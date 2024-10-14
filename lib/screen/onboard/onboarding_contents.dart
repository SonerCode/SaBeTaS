class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Beslenme ve sağlık yolculuğunuzda size eşlik etmek için buradayız!",
    image: "assets/images/1.png",
    desc: "Yeni diyetisyen uygulamamıza hoş geldiniz. Artık sağlıklı yaşam tarzınızı desteklemek ve hedeflerinize ulaşmak için güçlü bir yardımcınız var.",
  ),
  OnboardingContents(
    title: "Bu yolculukta yanınızdayız.",
    image: "assets/images/2.png",
    desc:
        "Uygulamamız size özel olarak tasarlanmış beslenme planları sunarak sizinle birlikte gelişecek.",
  ),
  OnboardingContents(
    title: "Bizi tercih ettiğiniz için mutluyuz.",
    image: "assets/images/3.png",
    desc:
        "Uygulamamızı kullanmaya başlamak için hemen giriş yapın ve sağlıklı yaşamınızın anahtarını keşfedin.",
  ),
];
