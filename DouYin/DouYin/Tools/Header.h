//
//  Header.h
//  DouYin
//
//  Created by Joe on 2019/7/18.
//  Copyright © 2019 Joe. All rights reserved.
//

#ifndef Header_h
#define Header_h


#import <CocoaLumberjack/CocoaLumberjack.h>
#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#endif /* Header_h */
