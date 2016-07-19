//
//  LREffectCell.h
//  LRLayerSuperposition
//
//  Created by 卢然 on 16/7/18.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LREffectCell : UITableViewCell

/**
 *  背景图
 */
@property (nonatomic, weak)UIImageView *backGImage;

/**
 *  cell偏移设置
 */
- (void)cellOffsetOnTabelView:(UITableView *)tabelView;

/**
 *  创建cell
 */
+ (instancetype)cellFromTableView:(UITableView *)tableView;

@end
