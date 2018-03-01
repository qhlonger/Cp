//
//  Constants.h
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#define BgLightGray CPRGB(250,250,250)
#define MainBgGray CPRGB(245,245,245)
#define BgDarkGray CPRGB(220,220,220)


#define MainBorderColor CPRGBA(223,60,82, 0.2)

#define MainColor CP16Color(0xDF3C52)
#define DarkMainColor CPRGB(150,43,52)
#define LightMainColor CP16Color(0xC56368)

#define MainGradientColor1 CP16Color(0xC2282F)
#define MainGradientColor2 CP16Color(0xFF5B72)

#define GreenColor CP16Color(0x41A92D)


#define TextBlackColor CP16Color(0x333333)
#define TextDarkGrayColor CPRGB(100,100,100)
#define TextGrayColor CPRGB(150,150,150)
#define TextLightGrayColor CPRGB(200,200,200)

#define TabBarTintColor CPRGBA(255,255,255,0.6)
#define TabBarSelTintColor  CPRGB(255,255,255)
#define TabBarBgColor MainColor

#define SepColor CP16Color(0xE8E8E8)

#define OrangeBgColor CP16Color(0xFAF0E1)

#define BlueBallColor CP16Color(0x3A90D3)
#define RedBallColor CP16Color(0xDF3C52)
#define GrayBallColor TextGrayColor

#define TitleFont PtOn47(12)


#define SRadius PtOn47(4)
#define MRadius PtOn47(8)

#define RowH PtOn47(44)

#define NormalMargin PtOn47(10)

//必须
#define TabBarItemSelImages @[@"tabbar_gc",@"tabbar_kj",@"tabbar_phb",@"tabbar_gr"]
//必须
#define TabBarItemTitles @[@"购彩大厅",@"开奖信息",@"榜上有名",@"用户中心"]
//非必须
#define TabBarItemImages @[]




#define RootPath @"http://192.168.0.194"
#define AppID    @"212"



#endif /* Constants_h */
