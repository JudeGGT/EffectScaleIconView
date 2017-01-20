//
//  GGTViewController.m
//  TableView
//
//  Created by ggt on 2017/1/20.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "GGTViewController.h"
#import "GGTEffectScaleIconView.h"

const CGFloat kHeight = 200.0f;

@interface GGTViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) GGTEffectScaleIconView *effectScaleIconView;

@end

@implementation GGTViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self setupUI];
    [self setContraints];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)dealloc {
    
    [self.effectScaleIconView removeFromSuperview];
}

#pragma mark - UI

/**
 UI界面
 */
- (void)setupUI {
    
    GGTEffectScaleIconView *effectScaleIconView = [[GGTEffectScaleIconView alloc] initWithTableView:self.tableView];
    effectScaleIconView.effectHeight = 200;
    effectScaleIconView.iconWH = 100;
    effectScaleIconView.iconImageURL = @"http://img.hb.aicdn.com/00d17e5e1c47e170cf4b6efea7abd1aafd17bd699aae-014spL_fw658";
    self.effectScaleIconView = effectScaleIconView;
}

#pragma mark - Constraints


/**
 设置约束
 */
- (void)setContraints {
    
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0],
                                [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0],
                                [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0],
                                [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]
                                ]];
}

#pragma mark - Custom Accessors

#pragma mark - IBActions

#pragma mark - Public

#pragma mark - Private

#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

#pragma mark - Lazy

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.contentOffset = CGPointMake(0, -kHeight);
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

@end
