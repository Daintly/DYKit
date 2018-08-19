//
//  UIScrollView+DGRefresh.m
//  DaintyKit
//
//  Created by Dainty on 17/2/24.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import "UIScrollView+DGRefresh.h"

//#import <MJRefresh.h>
@implementation UIScrollView (DGRefresh)

- (void)addHeaderRefresh:(void (^)())handler{
    self.mj_header = [DYRefreshHeader headerWithRefreshingBlock:handler];
    //取消之前的所有请求
//    [[DYHTTPTool sharedInstance].tasks makeObjectsPerformSelector:@selector(cancel)];

}
- (void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
}
- (void)endHeaderRefresh{
    [self.mj_header endRefreshing];
}
- (void)addFooterRefresh:(void (^)())handler{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:handler ];
    
    //取消之前的所有请求
//    [[DYHTTPTool sharedInstance].tasks makeObjectsPerformSelector:@selector(cancel)];
}
- (void)beginFooterRefresh{
    [self.mj_footer beginRefreshing];
}
- (void)endFooterRefresh{
    [self.mj_footer endRefreshing];
}
 
@end
