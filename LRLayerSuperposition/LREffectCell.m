//
//  LREffectCell.m
//  LRLayerSuperposition
//
//  Created by 卢然 on 16/7/18.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import "LREffectCell.h"
#import "UIView+Frame.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

#define LRCellHeight 150

#define LRLastCellHeight 230

static NSString * const LRCellId = @"LREffectCellId";

@interface LREffectCell ()

@property (nonatomic, weak)UIView *backGView;

@end

@implementation LREffectCell


- (UIView *)backGView {
    
    if (!_backGView) {
        UIView *view = [UIView new];
        view.clipsToBounds = YES;
        [self.contentView addSubview:view];
        _backGView = view;
    }
    return _backGView;
}

- (UIImageView *)backGImage {
    
    if (!_backGImage) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.backGView addSubview:imageView];
        _backGImage = imageView;
        
    }
    return _backGImage;
}


+ (instancetype)cellFromTableView:(UITableView *)tableView
{
    
    LREffectCell *cell = [tableView dequeueReusableCellWithIdentifier:LRCellId];
    
    if (!cell) {
        
        cell = [[LREffectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LRCellId];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        //content and subviews are clipped to the bounds of the view
        self.clipsToBounds = NO;
        self.backGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, LRCellHeight);
        self.backGImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, LRLastCellHeight);
    }
    return self;
}



- (void)cellOffsetOnTabelView:(UITableView *)tabelView
{
    
    CGFloat currentLocation = tabelView.contentOffset.y + LRLastCellHeight;
    
#if 0
    //下拉禁止 第一个cell往下移动
    if (currentLocation < LRCellHeight) return;
#endif
    
    //如果超出规定的位置以 ->“上”
    if (self.frame.origin.y < tabelView.contentOffset.y + LRLastCellHeight - LRCellHeight) {
        
        self.backGView.height = LRLastCellHeight;
        
        self.backGView.y = - (LRLastCellHeight - LRCellHeight);
        
        
    }else if (self.frame.origin.y <= currentLocation && self.frame.origin.y >= tabelView.contentOffset.y) {//cell开始进入规定的位置
        
        //通过绝对值 取出移动的Y值
        CGFloat moveY = ABS(self.frame.origin.y - currentLocation) / LRCellHeight * (LRLastCellHeight - LRCellHeight);
        
        //每次进来把当前cell提到最上层
        [self.superview bringSubviewToFront:self];
        
        //移动的值 + cell固定高度
        self.backGView.height = LRCellHeight + moveY;
        
        //设置偏移量Y值
        self.backGView.y = - moveY;
        
    }else{//超出规定的位置以 ->“下”
        
        self.backGView.height = LRCellHeight;
        
        self.backGView.y = 0;
    }
}

@end
