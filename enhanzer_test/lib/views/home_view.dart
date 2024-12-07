import 'package:enhanzer_test/utilities/global_exports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarLeading(
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        title: const AppBarTitle(title: 'Quotation'),
        actions: [
          AppBarBackButton(onTap: () {}),
          AppBarSaveButton(onTap: () {}),
        ],
        backgroundColor: const Color(0xFF02528F),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    hint: const Text(
                      'Select Store',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF02528F),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'auckland',
                        child: Text('Auckland Offices'),
                      ),
                      DropdownMenuItem(
                        value: 'christchurch',
                        child: Text('Christchurch Offices'),
                      ),
                      DropdownMenuItem(
                        value: 'wellington',
                        child: Text('Wellington Offices'),
                      ),
                    ],
                    onChanged: (val) {},
                    isDense: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF02528F),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: const Color(0xFF02528F), width: 3)),
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  indicatorColor: const Color(0xFF02528F),
                  indicator: const BoxDecoration(
                    color: Color(0xFF02528F),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF02528F),
                  labelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  tabs: const [
                    Tab(text: 'General'),
                    Tab(text: 'Items'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                },
                children: const [
                  GeneralView(),
                  ItemsView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
