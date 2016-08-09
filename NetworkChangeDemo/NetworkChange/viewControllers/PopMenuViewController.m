//
//  PopMenuViewController.m
//  NetworkChangeDemo
//
//  Created by DBC on 16/8/8.
//  Copyright © 2016年 DBC. All rights reserved.
//

#import "PopMenuViewController.h"
#import "PopMenuView.h"

@interface PopMenuItem : NSObject
@property (nonatomic, strong) NSString *name; // 名称
@property (nonatomic, strong) NSString *type; // 类型  1 生产  2 开发
@property (nonatomic, strong) NSString *kHost; // 主域名
@property (nonatomic, strong) NSString *KUrl;   // 网络请求url
@property (nonatomic, strong) NSString *kWebURL; // html 链接 url
@end

@implementation PopMenuItem

@end

@interface PopMenuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PopMenuViewController{
    NSMutableArray *_dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [PopMenuView shareView].hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [PopMenuView shareView].hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"网络切换";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PopMenuNetworkList.plist" ofType:nil];
    
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    _dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        PopMenuItem *item = [[PopMenuItem alloc] init];
        item.name = dic[@"name"];
        item.type = dic[@"type"];
        item.kHost = dic[@"kHost"];
        item.KUrl = dic[@"KUrl"];
        item.kWebURL = dic[@"kWebURL"];
        [_dataArray addObject:item];
    }
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell_menu"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell_menu"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    PopMenuItem *item = _dataArray[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PopMenuItem *item = _dataArray[indexPath.row];
    kHost = item.kHost;
    kWebURL = item.kWebURL;
    KUrl = item.KUrl;
    NSLog(@"%@", kHost);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
