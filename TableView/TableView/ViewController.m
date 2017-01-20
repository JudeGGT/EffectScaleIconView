//
//  ViewController.m
//  TableView
//
//  Created by ggt on 2017/1/19.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "ViewController.h"
#import "GGTViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    GGTViewController *vc = [[GGTViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
