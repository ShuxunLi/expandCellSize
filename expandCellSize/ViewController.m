//
//  ViewController.m
//  expandCellSize
//
//  Created by 聚财道 on 16/5/18.
//  Copyright © 2016年 jucaidao. All rights reserved.
//

#import "ViewController.h"
#import "ExpandCellSizeTableViewCell.h"

#define kCellHeight 60

@interface ViewController ()
{
    NSIndexPath *_expandedIndexPath;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#define mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* acountCllIdentifier = @"ExpandCellSizeTableViewCell";
    
    ExpandCellSizeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:acountCllIdentifier];
    
    if (!cell)
        cell = [[[NSBundle mainBundle] loadNibNamed:acountCllIdentifier owner:nil options:nil] lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(_expandedIndexPath != nil && _expandedIndexPath.row == indexPath.row){
        cell.bottomView.hidden = NO;
    }else{
        cell.bottomView.hidden = YES;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGFloat additionalHeight = 0;
    
    if(_expandedIndexPath && indexPath.row == _expandedIndexPath.row){
        additionalHeight = 30;
    }
    return kCellHeight + additionalHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath* oldPath = _expandedIndexPath;
    if(_expandedIndexPath && [_expandedIndexPath isEqual: indexPath]) {
        _expandedIndexPath = nil;
    }else{
        _expandedIndexPath = indexPath;
    }
    
    NSMutableArray* indexPaths = [NSMutableArray array];
    if(_expandedIndexPath)
        [indexPaths addObject:_expandedIndexPath];
    if(oldPath)
        [indexPaths addObject:oldPath];
    if([indexPaths count] > 0)
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
