//
//  DefineHeader.h
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#ifndef DefineHeader_h
#define DefineHeader_h

NS_INLINE CGFloat kSafeAreaTopInset(){
    CGFloat top = 0;
    if (@available(iOS 11.0, *)) {
        top = [[UIApplication sharedApplication].windows firstObject].safeAreaInsets.top;
    }
    return top;
}

NS_INLINE CGFloat kSafeAreaBottomInset(){
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = [[UIApplication sharedApplication].windows firstObject].safeAreaInsets.bottom;
    }
    return bottom;
}

NS_INLINE CGFloat kTNavigationBarHeight(){
    static CGFloat navHeight = 0;
    if (navHeight > 0) {
        return navHeight;
    }
    navHeight = 64;
    if (@available(iOS 11.0, *)) {
        CGFloat top = [[UIApplication sharedApplication].windows firstObject].safeAreaInsets.top;
        navHeight = top > 0 ? [[UIApplication sharedApplication].windows firstObject].safeAreaInsets.top + 44 : 64;
    }
    return navHeight;
}


#endif /* DefineHeader_h */
