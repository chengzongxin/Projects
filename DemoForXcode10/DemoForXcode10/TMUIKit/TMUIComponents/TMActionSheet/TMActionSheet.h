//
//  TMActionSheet.h
//  Masonry
//
//  Created by nigel.ning on 2020/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TMActionSheetActionStyle) {
    TMActionSheetActionStyleDefault = 0,    ///< 按钮字显示为 普通号蓝色
    TMActionSheetActionStyleCancel,         ///<  取消按钮的字显示为 加粗号蓝色
    TMActionSheetActionStyleDestructivem,   ///< 按钮字显示为 普通号红色
    TMActionSheetActionStyleGray            ///< 按钮字显示为 普通号黑灰色
};

@interface TMActionSheetAction: NSObject
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(TMActionSheetActionStyle)style handler:(void (^ __nullable)(TMActionSheetAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) TMActionSheetActionStyle style;
@end

/**
 封装actionSheet样式的自定义控件
 包含可自定义的title\message\actions
 @note 取消按钮也需要主动添加才会有，默认不会添加任何按钮
 @warning 对应的action最多只有一个style为cancel类型，若添加多个cancel类型则会抛出异常
 @warning 添加的按钮顺序，若为cancel类型则会始终在最下方单独一个按钮来j显示，其它类型按添加的顺序进行展示
 */
@interface TMActionSheet : NSObject

+ (instancetype)showWithTitle:(NSString *_Nullable)title                         
                         actions:(NSArray<TMActionSheetAction *> *)actions
              fromViewController:(UIViewController *)fromVc;

/**当视图显示后可以调用此函数动态继续添加操作按钮*/
- (void)addActions:(NSArray<TMActionSheetAction *> *)actions;

@end

NS_ASSUME_NONNULL_END
