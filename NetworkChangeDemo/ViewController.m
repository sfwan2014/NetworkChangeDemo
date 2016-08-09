//
//  ViewController.m
//  NetworkChangeDemo
//
//  Created by DBC on 16/8/8.
//  Copyright © 2016年 DBC. All rights reserved.
//

#import "ViewController.h"
#import "PopMenuView.h"
#import "PopMenuViewController.h"
NSString *kHost = @"http://www.dbc61.com/";
NSString *KUrl = @"http://www.dbc61.com/app/";
NSString *kWebURL = @"http://www.dbc61.com/store/html/";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    __weak ViewController *this = self;
    PopMenuView *menu = [PopMenuView shareView];
    [menu showCallback:^{
        PopMenuViewController *vc = [[PopMenuViewController alloc] initWithNibName:@"PopMenuViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [this presentViewController:nav animated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)push:(id)sender {
    
    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
