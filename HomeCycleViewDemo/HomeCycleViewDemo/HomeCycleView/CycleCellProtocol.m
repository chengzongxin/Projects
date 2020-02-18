//
//  CycleCellProtocol.m
//  HomeCycleViewDemo
//
//  Created by Joe on 2020/2/18.
//  Copyright © 2020年 Joe. All rights reserved.
//

#import "CycleCellProtocol.h"

@implementation CycleCell

- (void)autoScroll {

}

- (void)didEndDragging {
    
}


- (void)willBeginDragging {
    
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.delegate) {
        [self.delegate willBeginDragging];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.delegate) {
        [self.delegate didEndDragging];
    }
}

@end
