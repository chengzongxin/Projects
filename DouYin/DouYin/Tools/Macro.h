//
//  Macro.h
//  DouYin
//
//  Created by Joe on 2019/7/18.
//  Copyright © 2019 Joe. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width

#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

#define SafeAreaTopHeight ((SCREEN_HEIGHT >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 88 : 64)

#define SafeAreaBottomHeight ((SCREEN_HEIGHT >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 30 : 0)

#endif /* Macro_h */
