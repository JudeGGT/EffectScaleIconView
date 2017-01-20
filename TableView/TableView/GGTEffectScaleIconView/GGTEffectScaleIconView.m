//
//  GGTEffectScaleIconView.m
//  TableView
//
//  Created by ggt on 2017/1/19.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "GGTEffectScaleIconView.h"

@interface GGTEffectScaleIconView ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIVisualEffectView *effectView;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, strong) NSArray *cont;
@property (nonatomic, strong) NSLayoutConstraint *heightContraint;
@property (nonatomic, strong) NSMutableData *imageData;

@end

@implementation GGTEffectScaleIconView

#pragma mark - Lifecycle

- (instancetype)initWithTableView:(UITableView *)tableView {
    
    if (self = [super init]) {
        _tableView = tableView;
        [self addObserver];
        [self setupUI];
    }
    
    return self;
}

- (void)dealloc {
    
    [self removeObserVer];
}


#pragma mark - UI

- (void)setupUI {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView addSubview:self];
    
    // 1.背景图片
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imgView];
    self.imgView = imgView;
    
    // 2.毛玻璃
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = imgView.frame;
    _effectView = effectView;
    effectView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_effectView];
    
    // 3.头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [effectView addSubview:iconImageView];
    self.iconImageView = iconImageView;
}

#pragma mark - Constraints

- (void)setConstraints {
    
    // 1.self
    [self.tableView addConstraints:@[
                                     [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
                                     [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f],
                                     self.heightContraint]
                                     ];
    
    // 2.背景图片
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.imgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.imgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.imgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.imgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]
                           ]];
    
    // 3.毛玻璃
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.effectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.effectView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.effectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.effectView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]
                           ]];
}

#pragma mark - Custom Accessors

- (void)setIconImage:(UIImage *)iconImage {
    
    _iconImage = iconImage;
    self.iconImageView.image = iconImage;
    self.imgView.image = iconImage;
}

- (void)setIconImageURL:(NSString *)iconImageURL {
    
    _iconImageURL = iconImageURL;
    [self downLoadImageWithURL:[NSURL URLWithString:iconImageURL]];
}

- (void)setEffectHeight:(CGFloat)effectHeight {
    
    _effectHeight = effectHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(effectHeight, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -effectHeight);
    self.heightContraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:self.effectHeight];
    [self setConstraints];
}

- (void)setIconWH:(CGFloat)iconWH {
    
    _iconWH = iconWH;
    self.iconImageView.layer.cornerRadius = iconWH * 0.5;
    [self.effectView addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.effectView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.effectView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0f constant:iconWH],
                           [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:iconWH]
                           ]];
}

#pragma mark - IBActions

#pragma mark - Public

- (void)removeObserVer {
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - Private

- (void)downLoadImageWithURL:(NSURL *)url {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        self.iconImage = image;
    }];
    
    [task resume];
}


/**
 监听
 */
- (void)addObserver {
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 响应监听事件
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        // 向下的话 为负数
        CGFloat off_y = self.tableView.contentOffset.y;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        // 下拉超过照片的高度的时候
        if (off_y < -self.effectHeight)
        {
            
            self.heightContraint.constant = -off_y;
            
            // 对应调整毛玻璃的效果
            self.effectView.alpha = 1 + (off_y + self.effectHeight) / height ;
        }
    } 
}


#pragma mark - Protocol


@end
