//
//  MarkDetail.m
//  SwellPro
//
//  Created by MM on 2018/1/3.
//  Copyright © 2018年 MM. All rights reserved.
//

#import "MarkDetail.h"
#import "Masonry.h"

@interface MarkDetail()
//左边
@property (nonatomic,strong) UIView *leftView;
//高度
@property (nonatomic,strong) UILabel *heightLabel;
//速度
@property (nonatomic,strong) UILabel *speedLabel;
//经纬度
@property (nonatomic,strong) UILabel *jwLabel;
//编辑
@property (nonatomic,strong) UIButton *editBtn;
//go按钮
@property (nonatomic,strong) UIButton *goBtn;
@end
@implementation MarkDetail
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    //左边
    _leftView = [[UIView alloc] init];
    _leftView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"map_markbg"]];
    [self addSubview:_leftView];
    //高度
    _heightLabel = [[UILabel alloc] init];
    _heightLabel.text = @"高度20米";
    _heightLabel.font = [UIFont systemFontOfSize:14];
    [_leftView addSubview:_heightLabel];
    //速度
    _speedLabel = [[UILabel alloc] init];
    _speedLabel.text = @"速度5米/秒";
    _speedLabel.font = [UIFont systemFontOfSize:14];
    [_leftView addSubview:_speedLabel];
    //经纬度
    _jwLabel = [[UILabel alloc] init];
    _jwLabel.text = @"经度：113.3456789   纬度：34.3456789";
    _jwLabel.textColor = [UIColor darkGrayColor];
    _jwLabel.font = [UIFont systemFontOfSize:12];
    [_leftView addSubview:_jwLabel];
    //编辑
    _editBtn = [[UIButton alloc] init];
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"map_edit"] forState:UIControlStateNormal];
    [_leftView addSubview:_editBtn];
    //go按钮
    _goBtn = [[UIButton alloc] init];
    [_goBtn setBackgroundColor:[UIColor colorWithRed:220/225 green:111/225 blue:80/225 alpha:1.0]];
    [_goBtn setTitle:@"GO" forState:UIControlStateNormal];
    [_goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_goBtn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //左边
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).with.offset(-25);
    }];
    //高度
    [_heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(4);
    }];
    //速度
    [_speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_heightLabel.mas_right).with.offset(8);
        make.top.mas_equalTo(_heightLabel);
    }];
    //经纬度
    [_jwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_heightLabel.mas_bottom).with.offset(4);
        make.left.mas_equalTo(_heightLabel);
    }];
    //编辑
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_leftView).with.offset(-10);
    }];
    //go按钮
    [_goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_leftView.mas_right);
    }];
    
}
@end
