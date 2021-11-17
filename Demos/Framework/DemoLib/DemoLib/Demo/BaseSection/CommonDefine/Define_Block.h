//
//  Define_Block.h
//  JJTYG_IPhone
//
//  Created by 程 司 on 14-4-3.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#ifndef JJTYG_IPhone_Define_Block_h
#define JJTYG_IPhone_Define_Block_h

/***********************************************************************************************************************/

#pragma mark - BLOCK

typedef void (^T8TBasicBlock)(void);

typedef void (^T8TBOOLBlock)(BOOL value);

typedef void (^T8TIndexBlock)(NSInteger value);
typedef void (^T8TTextBlock)(NSString *string);
typedef void (^T8TObjBlock)(id object);
typedef void (^T8TFloatBlock)(CGFloat value);
typedef bool (^T8TReturnBlock)(void);

typedef void (^T8TDictionaryBlock)(NSDictionary *dict);

typedef id (^TReturnObjectWithOtherObjectBlock)(id object);
typedef UIImage *(^TReturnImgWithImgBlock)(UIImage *image);
typedef void (^TArrBlock)(NSArray *array);

typedef void (^T8TBtnBlock)(UIButton *btn);

#endif
