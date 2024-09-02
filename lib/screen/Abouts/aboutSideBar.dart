// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:itckfa/Option/components/contants.dart';

import 'package:readmore/readmore.dart';

class AboutSidebar extends StatefulWidget {
  const AboutSidebar({Key? key}) : super(key: key);

  @override
  State<AboutSidebar> createState() => _AboutSidebarState();
}

class _AboutSidebarState extends State<AboutSidebar> {
  String content =
      "\tKhmer Foundation Appraisals (KFA), Co., Ltd, is a legal and one of the top 5 Real Estates and Consulting Companies founded by Oknha Noun Rithy who has over 10 years experiences in Real Estates market in Cambodia. The KFA Company was registered with the Ministry of Economy and Finance with its registration number EV-15-165 and Ministry of Commerce with its registration number Co. 0206 KH/2015.\n\n"
      "\tThe Company brings an in-depth understanding and knowledge of sales, leasing, and consulting services across Cambodia and has created numerous successful real estate transactions throughout the country. The Company provides Asset and Property Appraisals, Property Consultancy for both selling and leasing property across Cambodia, including Property Management, Investment, Development, Engineering, and Construction. The Company also provides appraisals services for mortgage origination, relocation, forced sales, reviews, bankruptcy, asset valuation, share allocation, divorce, trust/estate matters, and court testimony.\n\n"
      "\tIn response to the demand of the costumers’ needs, KFA has expended its branch offices in Siem Reap, Kompong Cham, and Kompot provinces. Our technical and professional teams have worked very closely between those offices. We have equipped and manned with full staff and facilities at our branch offices in those provinces.\n\n"
      "\tImpressively, the Company was selected and granted the International Quality Crown Award in 2017 by the BID Group and IQC Selection Committee in London, England. And subsequently the Company was also selected and awarded the Cambodia Real Estate AWARD 2018 by the Realestate.com.kh. Amazingly, the Company becomes one of the leading and top 5 Real Estates Companies in Cambodia and has built more business partners across the country. We are here to guarantee your business transaction to go as smoothly as possible.\n\n";
  String message = "\n\tDear Valued Customers,\n\n"
      "First of all, allow me express my wholehearted thanks to you for your tireless supports and trusts in using our valuation and property consultancy services. Words are not enough to express our sincere and grateful thanks to you. We guaranty you that we faithfully serve you with your needs and provide you with the highest standard of services. In addition, we also provide you with protection against a loss or other financial burden via our indemnity.\n\n"
      "\tOur company and/or valuers strictly follow and use many valuation methods or techniques based on the valuation propose. They are: 1. Sale Comparison Approach, 2. Cost Approach, 3. Income Approach, 4. Discount Cash Flow Approach.\n\n"
      "\tWe strictly adhere to your highest satisfactions and expectations. We understand your needs and/or investments and we listen to your problems and provide you with the best solutions.\n\n"
      "\tOur top priority and focus in this business is to serve you in the highest standard and professional manner for your successful businesses and investments. We place our integrity in the heart of whatever we do. Providing a highest level of services in a high ethical, trustworthy, professional, and transparent manner is of utmost importance to your businesses and investments. And that KFA Company is the right choice for you.\n\n"
      "\tWe take pride of ourselves in the commitment, dedication and loyalty we provide you in serving your needs, no matter how challenging the requirements are. You will appreciate our consistency, professionalism and the greatest results we deliver.\n\n"
      "\tLast but not least, if you are interested in asset and property appraisal, buying, selling, leasing of lands, houses, villas, warehouses, and other commercial buildings, please contact our Company. We will assist you accordingly.\n\n"
      "\tFinally, once again, I sincerely and deeply thank you and appreciate you for taking your time to learn more about our company and use our professional and transparent services.\n\n"
      "\tPlease feel free to contact us at Hotlines: Phnom Penh. (855) 77 216 168. KampongCham. (855) 77 274 168. Siem Reap. (855) 77 275 168. Battambang. (855) 77 273 168. Kampot. (855) 260 168 or access to our Website at www.kfa.com.kh should you need further information.\n\nBest regards,\n\n";

  String overview =
      "\tKhmer Foundation Appraisals (KFA), Co., Ltd, is a legal, registered and one of the top 5 Real Estates and Consulting Companies founded by Oknha Noun Rithy who has over 10 years experiences in Real Estates industries in Cambodia. The KFA Company was licensed by the Ministry of Economy and Finance with its registration number EV-15-165.\n\n"
      "\tThe Company brings an in-depth understanding and extensive knowledge of valuation, sales, leasing, and consulting services across Cambodia and has created numerous successful real estate transactions throughout the country. The Company provides Asset and Property Appraisals, Property Consultancy for both selling and leasing property across Cambodia, including Property Development, Management, Investment, Engineering, and Construction. The Company also provides appraisals services for mortgage origination, relocation, forced sales, reviews, bankruptcy, asset valuation, share allocation, divorce, trust/estate matters, and court testimony.\n\n"
      "\tThe Company’s regulations and policies conform to National and International standards of business ethics in the delivery of the professional real estate services and more. The management and staff of the Company are committed to providing the best services to the clienteles in an absolutely honest, reliable, confident, transparent, independent and efficient manner.\n\n"
      "\tThe Company’s Professional Valuation Team of creative, dynamic, well trained valuation appraisers and/or valuers with tremendous and excellent skills in the Real Estate market, is ready to providing its esteemed customers with an efficient, quality and transparent services by using the most unique and innovative databases system, which maintains all the past and current data in the system. In response to the demands of the costumers’ needs, KFA has expanded its branch offices to Battambang, Siem Reap, Kompong Cham, and Kompot provinces. Our technical and professional teams have worked very closely between these offices. We have equipped and manned with full staff and facilities at our branch offices in these provinces\n\n"
      "\tImpressively and consecutively within the last 3 years of its business, KFA has received the International Quality Crown Award in 2017 by the BID Group and IQC Selection Committee in London, England, received the Valuation Company of the Year Award by the Realestate.com.kh 2018 and received another honorable Award (The BIZZ AMERICAS 2019) for Excellent in Businesses Leadership, Managerment, Marketing Management, Quality Managment and Innovative Knowledgeable and Systematic Manner in San Francisco, California, USA by the World Confederation of Business. As a result, the Company becomes one of the leading and top 5 Real Estates Companies in Cambodia and has built more business partners across the country. We are here to guarantee your business transaction to go as smoothly as possible. If you’d like to engage in our services or simply want to know more, please feel free to contact us at Hotlines: Phnom Penh. (855) 77 216 168. Kampong Cham. (855) 77 274 168. Siem Reap. (855) 77 275 168. Battambang. (855) 77 273 168. Kampot. (855) 260 168 or access to our Website at www.kfa.com.kh.\n\n";
  String vision = "\tVISION\n"
      "\t To become the leading Real Estate Company in Cambodia providing National and International class Real Estate Services that meet our clients’ needs at all time.\n\n"
      "\tMISSION\n"
      "\t We exist to provide National and International class services in the area of our core competences that leave our clients happy and thoroughly satisfied.\n\n";
  // "\tCORE VALUE\n"
  // "\tKeep our clients satisfied; our colleagues/collaborators happy; our staffs fulfilled and motivated; our management proud and celebrated; our brand competitive and progressive.\n\n"
  // "\tINTEGRITY:\n"
  // "\t We keep our promises  we walk the talk.\n We are honest, trustworthy and ethical in our all actions.\n\n"
  // "\tCOMPETENCE\n"
  // "\t We are research driven.\nWe give reliable information that help our clients make the right decisions.\n\n"
  // "\tQUALLY CLIENT/CUSTOMER SERVICE\n"
  // "\t Our clients are the driving force of our existence; keeping them satisfied is the fundamental reason for our existence.\n We focus on opportunities where we can establish competitive advantage and deliver outstanding results.\n\n"
  // "\tTEAM WORK\n"
  // "\t We work together to achieve more.\n\t We commit to achieving common goals.\n\t We support one another.\n\n"
  // "\tPROMPT DELIVERY\n"
  // "\t We are quick to act and respond to clients’ needs.\n\t We perform our duties without delay.\n\n"
  // "\tCOMPETENCE\n"
  // "\t We are professional and adaptable to the varied needs of our clients.\n We leverage on our collective strength to provide exceptional services.\n\n";
  String ourpeople =
      "\tKFA sticks and adheres to its highest professionalism, integrity and transparency in its services. With years of experiences and trust given by the customers in asset and property valuation, property consultancy, property development and customer relations, we diligently work to provide the best care of costumers’ investments and businesses.\n\n"
      "\tWhat this means is that we maintain our excellent relationship and high integrity with our valued customers and tenants and diligently caring of their investment and business needs and requirements. We, as much as we can, avoid any potential problems, which would happen or harm to the costumers’ investments and businesses.\n\n";
  String profile =
      "\tWhether you are property owners, tenants, or buyers, we value your businesses and provide you with the individual attention and exceptional services you deserve. We believe in a strict Code of Ethics. And we believe in integrity and commitment to excellence, professional attitude, and personalized cares.\n\n"
      "\tKhmer Foundation Appraisals (KFA) Co., and its professional team have significant and countless hands-on experiences in all facets of the real estate industries, including buying, selling, leasing, brokerage, management, financing, land development, and property appraisals. KFA has served its clients in real estate market throughout Cambodia for many years.\n\n"
      "\tBuilding on our tremendous and extensive knowledge, experience, and expertise, KFA provides professional and transparent services to clients based on the zoning and current market value of the properties. Historically, KFA has gained honorable and incredible reputations in serving a wide range of services from its clients nationally and internationally. We take pride in our incredible reputations of initiating and implementing the successful real estate strategies for our clients\n\n"
      "\tOur philosophy is based on a true commitment to values with individual client strategy designed to assure maximization of values over a wide range of market conditions. Subsequently, each of our service-oriented project teams focus on a client's particular goals and objectives as we professionally direct their real estate investments and businesses. Professionalism and high ethical business practices have always been a guiding force in the success of Khmer Foundation Appraisals Co., Ltd."
      "\t\n\n";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite_new,
      appBar: AppBar(
        backgroundColor: kwhite_new,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'About us',
          style: TextStyle(
            //color: Color.fromRGBO(169, 203, 56, 1),
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),

          //image: 'assets/images/kfa.jpg',
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(25),
                  // topRight: Radius.circular(25),
                  ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HomeListView(
                //   scrollController: _scrollController,
                //   images: homeList,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 120,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: items.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 0,
                              ),
                              child: Image.asset(item),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome to Khmer Foundation Appraisals Co., Ltd.",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // SizedBox(
                //   width: 500,
                //   height: 145,
                //   child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: const [
                //         HomeCard(img: 'assets/images/kfa.jpg'),
                //         HomeCard(img: 'assets/images/Awards2020--.jpg'),
                //         HomeCard(img: 'assets/images/Awards2020.jpg'),
                //         HomeCard(img: 'assets/images/kfa1.png'),
                //         HomeCard(img: 'assets/images/slide15.jpg'),
                //         HomeCard(img: 'assets/images/forweb4.jpg'),
                //         HomeCard(
                //             img: 'assets/images/Real Estate Award 2019.jpg'),
                //       ]),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "About Us",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMore(text: content),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.blueAccent,
                  thickness: 0.5,
                ),
                Text(
                  "Founder & Chairman/CEO's Message",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Image(image: AssetImage('assets/images/message-banner3.jpg')),

                ReadMore(text: message),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.blueAccent,
                  thickness: 0.5,
                ),
                Text(
                  "Company Overview",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMore(text: overview),
                Divider(
                  color: Colors.blueAccent,
                  thickness: 0.5,
                ),
                Text(
                  "Vision and Mission",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMore(text: vision),
                Divider(
                  color: Colors.blueAccent,
                  thickness: 0.5,
                ),
                Text(
                  "Our People",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMore(text: ourpeople),
                Divider(
                  color: Colors.blueAccent,
                  thickness: 0.5,
                ),
                Text(
                  "Company Profile",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMore(text: profile),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage(
                        'assets/images/Company-Profile-Cover2020_1.png',
                      ),
                    ),
                    Image(
                      image: AssetImage(
                        'assets/images/Bank-Panel-for-web-icon.png',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List items = [
    "assets/images/kfa.jpg",
    'assets/images/Awards2020--.jpg',
    'assets/images/Awards2020.jpg',
    'assets/images/kfa1.png',
    'assets/images/slide15.jpg',
    'assets/images/forweb4.jpg',
    'assets/images/Real Estate Award 2019.jpg',
  ];
}

class ReadMore extends StatelessWidget {
  const ReadMore({
    Key? key,
    //required this.content,
    required this.text,
  }) : super(key: key);

  //final String content;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 6,
      textAlign: TextAlign.justify,
      trimMode: TrimMode.Line,
      trimCollapsedText: " read more ",
      trimExpandedText: " Show Less ",
      // lessStyle: TextStyle(
      //   fontWeight: FontWeight.bold,
      //   color: Colors.black54,
      // ),
      style: TextStyle(
        fontSize: 15,
        height: 1,
      ),
    );
  }
}
