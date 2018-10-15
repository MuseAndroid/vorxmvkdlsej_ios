//
//  FFResultIDView.h
//  factFinder
//
//  Created by Hong Junho on . 4. 2.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

@interface FFResultIDView : FFView

- (instancetype) init;

@property (copy) void (^move_login1)(void);

@property (copy) void (^move_FindPW)(void);

@property (strong, nonatomic) UILabel *lbUserIDTitle;
@property (strong, nonatomic) UILabel *lbUserID;
@property (strong, nonatomic) UIView *gubunLineView1;
@property (strong, nonatomic) UIButton *btnGoLogin1;
@property (strong, nonatomic) UIButton *btnMoveFindPW;

@end
