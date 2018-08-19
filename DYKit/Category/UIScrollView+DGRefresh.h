//
//  UIScrollView+DGRefresh.h
//  DaintyKit
//
//  Created by Dainty on 17/2/24.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIScrollView (DGRefresh)

- (void)addHeaderRefresh:(void(^)())handler ;
- (void)addFooterRefresh:(void(^)())handler ;
- (void)beginHeaderRefresh;
-(void)endHeaderRefresh;
- (void)endFooterRefresh;
-(void)beginFooterRefresh;



@end
