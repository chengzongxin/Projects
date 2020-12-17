//
//  TMInitMacro.h
//  Pods
//
//  Created by nigel.ning on 2020/7/23.
//

#ifndef TMInitMacro_h
#define TMInitMacro_h

//分别对UIView及NSObject的子类实现相关init方法时提取相关重复代码定义为宏，让子类的初始化过程中仅需专注于子类自身的变量或其它数据的初始化处理

#pragma mark - UI Init Methods Macro

#define TM_INIT_View_Override(...) \
- (instancetype)initWithFrame:(CGRect)frame {   \
    self = [super initWithFrame:frame]; \
    if (self) { \
        __VA_ARGS__;    \
    }   \
    return self;    \
}   \
    \
- (instancetype)initWithCoder:(NSCoder *)coder {    \
    self = [super initWithCoder:coder]; \
    if (self) { \
        __VA_ARGS__;    \
    }   \
    return self;    \
}   \


#pragma mark - NSObject Init Methods Macro

#define TM_INIT_Object_Override(...) \
- (instancetype)init {   \
    self = [super init]; \
    if (self) { \
        __VA_ARGS__;    \
    }   \
    return self;    \
}   \



#endif /* TMInitMacro_h */
