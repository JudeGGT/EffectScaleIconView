//
//  GGTEffectScaleIconView.h
//  TableView
//
//  Created by ggt on 2017/1/19.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGTEffectScaleIconView : UIView

@property (nonatomic, assign) CGFloat effectHeight; /**< 整体高度 */
@property (nonatomic, assign) CGFloat iconWH; /**< 头像宽高 */
@property (nonatomic, strong) UIImage *iconImage; /**< 头像图片 */
@property (nonatomic, copy) NSString *iconImageURL; /**< 图片链接地址 */

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)removeObserVer;

@end
