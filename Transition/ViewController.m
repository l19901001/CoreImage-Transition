//
//  ViewController.m
//  Transition
//
//  Created by lss on 2017/6/18.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "ViewController.h"
#import "SSViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *rows;

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    NSString *cellText = self.rows[indexPath.row];
    
    cell.textLabel.text = cellText;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row > self.viewControllers.count-1)return;
    NSString *className = self.viewControllers[indexPath.row];
    Class class = NSClassFromString(className);
    SSViewController *vc = [class new];
    vc.filterName = self.rows[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSArray *)rows
{
    if(_rows == nil){
        _rows = @[@"CIAccordionFoldTransition", @"CIBarsSwipeTransition",
                  @"CICopyMachineTransition", @"CIDisintegrateWithMaskTransition",
                  @"CIDissolveTransition", @"CIFlashTransition",
                  @"CIModTransition", @"CIPageCurlTransition",
                  @"CIPageCurlWithShadowTransition", @"CIRippleTransition",
                  @"CISwipeTransition"];
    }
    return _rows;
}

-(NSArray *)viewControllers
{
    if(_viewControllers == nil){
        _viewControllers = @[@"AccordionFoldVC", @"BarsSwipeTransitionVC",
                             @"CopyMachineTransitionVC", @"DisintegrateWithMaskTransitionVC",
                             @"DissolveTransitionVC", @"FlashTransitionVC"];
    }
    return _viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
