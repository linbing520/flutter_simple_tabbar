library flutter_simple_tabbar;

import 'package:flutter/material.dart';


typedef OnTabChange = void Function(int tabIndex); //tab切换时调用


///简单的tabbar，不需要设置TabControll
class SimpleTabBar extends StatefulWidget {

  final List<Widget> tabs; //tab
  final List<Widget> tabContents; //内容页
  final ValueNotifier changeIndex; //设置选中的索引,默认0
  final OnTabChange onTabChange;


  /// Whether this tab bar can be scrolled horizontally.
  ///
  /// If [isScrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isScrollable;

  /// The color of the line that appears below the selected tab.
  ///
  /// If this parameter is null, then the value of the Theme's indicatorColor
  /// property is used.
  ///
  /// If [indicator] is specified, this property is ignored.
  final Color indicatorColor;

  /// The thickness of the line that appears below the selected tab.
  ///
  /// The value of this parameter must be greater than zero and its default
  /// value is 2.0.
  ///
  /// If [indicator] is specified, this property is ignored.
  final double indicatorWeight;

  /// The horizontal padding for the line that appears below the selected tab.
  ///
  /// For [isScrollable] tab bars, specifying [kTabLabelPadding] will align
  /// the indicator with the tab's text for [Tab] widgets and all but the
  /// shortest [Tab.text] values.
  ///
  /// The [EdgeInsets.top] and [EdgeInsets.bottom] values of the
  /// [indicatorPadding] are ignored.
  ///
  /// The default value of [indicatorPadding] is [EdgeInsets.zero].
  ///
  /// If [indicator] is specified, this property is ignored.
  final EdgeInsetsGeometry indicatorPadding;

  /// Defines the appearance of the selected tab indicator.
  ///
  /// If [indicator] is specified, the [indicatorColor], [indicatorWeight],
  /// and [indicatorPadding] properties are ignored.
  ///
  /// The default, underline-style, selected tab indicator can be defined with
  /// [UnderlineTabIndicator].
  ///
  /// The indicator's size is based on the tab's bounds. If [indicatorSize]
  /// is [TabBarIndicatorSize.tab] the tab's bounds are as wide as the space
  /// occupied by the tab in the tab bar. If [indicatorSize] is
  /// [TabBarIndicatorSize.label], then the tab's bounds are only as wide as
  /// the tab widget itself.
  final Decoration indicator;

  /// Defines how the selected tab indicator's size is computed.
  ///
  /// The size of the selected tab indicator is defined relative to the
  /// tab's overall bounds if [indicatorSize] is [TabBarIndicatorSize.tab]
  /// (the default) or relative to the bounds of the tab's widget if
  /// [indicatorSize] is [TabBarIndicatorSize.label].
  ///
  /// The selected tab's location appearance can be refined further with
  /// the [indicatorColor], [indicatorWeight], [indicatorPadding], and
  /// [indicator] properties.
  final TabBarIndicatorSize indicatorSize;

  /// The color of selected tab labels.
  ///
  /// Unselected tab labels are rendered with the same color rendered at 70%
  /// opacity unless [unselectedLabelColor] is non-null.
  ///
  /// If this parameter is null, then the color of the [ThemeData.primaryTextTheme]'s
  /// bodyText1 text color is used.
  final Color labelColor;

  /// The color of unselected tab labels.
  ///
  /// If this property is null, unselected tab labels are rendered with the
  /// [labelColor] with 70% opacity.
  final Color unselectedLabelColor;

  /// The text style of the selected tab labels.
  ///
  /// If [unselectedLabelStyle] is null, then this text style will be used for
  /// both selected and unselected label styles.
  ///
  /// If this property is null, then the text style of the
  /// [ThemeData.primaryTextTheme]'s bodyText1 definition is used.
  final TextStyle labelStyle;

  /// The padding added to each of the tab labels.
  ///
  /// If this property is null, then kTabLabelPadding is used.
  final EdgeInsetsGeometry labelPadding;

  /// The text style of the unselected tab labels
  ///
  /// If this property is null, then the [labelStyle] value is used. If [labelStyle]
  /// is null, then the text style of the [ThemeData.primaryTextTheme]'s
  /// bodyText1 definition is used.
  final TextStyle unselectedLabelStyle;


  /// An optional callback that's called when the [TabBar] is tapped.
  ///
  /// The callback is applied to the index of the tab where the tap occurred.
  ///
  /// This callback has no effect on the default handling of taps. It's for
  /// applications that want to do a little extra work when a tab is tapped,
  /// even if the tap doesn't change the TabController's index. TabBar [onTap]
  /// callbacks should not make changes to the TabController since that would
  /// interfere with the default tap handler.
  final ValueChanged<int> onTap;

  SimpleTabBar(
      {Key key,
        this.tabs,
        this.tabContents,
        this.changeIndex,
        this.isScrollable = false,
        this.indicatorColor  = const Color(0Xffcccccc),
        this.indicatorWeight = 2.0,
        this.indicatorPadding = EdgeInsets.zero,
        this.indicator,
        this.indicatorSize,
        this.labelColor = const Color(0Xff000000),
        this.labelStyle,
        this.labelPadding,
        this.unselectedLabelColor = const Color(0Xffcccccc),
        this.unselectedLabelStyle,
        this.onTap,
        this.onTabChange,
      })
      :
        assert(tabs != null),
        assert(tabContents != null),
        assert(tabs.length == tabContents.length),
        super(key: key);

  @override
  SimpleTabBarState createState() => SimpleTabBarState();
}

class SimpleTabBarState extends State<SimpleTabBar> with SingleTickerProviderStateMixin{

  TabController tabController;
  int lastIndex;
  
  @override
  void initState() {
    super.initState();

    int tabLength = 0;
    if(widget.tabs != null) {
      tabLength = widget.tabs.length;
    }
    tabController = TabController(length: tabLength, vsync: this);
    if(widget.changeIndex != null) {
      widget.changeIndex.addListener(() {
        tabController.index = widget.changeIndex.value;
      });
      tabController.index = widget.changeIndex.value;
    }
    lastIndex = tabController.index;
    if(widget.onTabChange != null) {
      tabController.addListener(() {
        int previousIndex = tabController.previousIndex;
        int currentIndex = tabController.index;
        if(lastIndex != currentIndex && previousIndex != currentIndex) {
          lastIndex = currentIndex;
          widget.onTabChange(lastIndex);
        }
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
         children: <Widget>[
           TabBar(
             tabs: widget.tabs,
             controller:tabController,
             isScrollable:widget.isScrollable,
             indicatorColor:widget.indicatorColor,
             indicatorWeight:widget.indicatorWeight,
             indicatorPadding:widget.indicatorPadding,
             indicator:widget.indicator,
             indicatorSize:widget.indicatorSize,
             labelColor:widget.labelColor,
             labelStyle:widget.labelStyle,
             labelPadding:widget.labelPadding,
             unselectedLabelColor:widget.unselectedLabelColor,
             unselectedLabelStyle:widget.unselectedLabelStyle,
             onTap:widget.onTap,
           ),
           Expanded(
               flex: 1,
               child: TabBarView(
               controller:tabController,
               children: widget.tabContents,
             )
           )

         ],
       );
  }



 
 }