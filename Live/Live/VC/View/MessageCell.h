//
//  MessageCell.h
//  Live
//
//  Created by Joe.cheng on 2021/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *text;

@end

NS_ASSUME_NONNULL_END
