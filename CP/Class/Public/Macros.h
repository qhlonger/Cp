//
//  Macros.h
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define CPFont(x) [UIFont systemFontOfSize:[Utility ptOn47:x]]
//#define EMFont(x) [UIFont fontWithName:@".PingFangSC-Light" size:(NSInteger)(EMiPhonePlus_OR_Later?1.1*x:x)]
#define CPBoldFont(x) [UIFont boldSystemFontOfSize:[Utility ptOn47:x]]


/** 颜色*/
#define CPRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define CPRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define CP16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define TopPadding (IsIpx ? 44 : 20)
#define BottomPadding (IsIpx ? 34 : 0)
#define TabBarHeight 50
#define NavHeight 44
#define IsIpx  [Utility isIphoneX]
#define IsIp40 [Utility isIphone40orLow]
#define IsIp47 [Utility isIphone47]
#define IsIp55 [Utility isIphone55]



#define PtOn40(x) [Utility ptOn40:x]
#define PtOn47(x) [Utility ptOn47:x]
#define PtOn55(x) [Utility ptOn55:x]
#define PtOn58(x) [Utility ptOn58:x]



#endif /* Macros_h */
