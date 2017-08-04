//
//  LCAppShowTableView.m
//  DBao
//
//  Created by 雪域科技 on 16/6/13.
//  Copyright © 2016年 雪域科技. All rights reserved.
//

#import "LCAppShowTableView.h"

@interface LCAppShowTableView ()
@property(nonatomic, weak)UITableView *table;
@property(nonatomic, weak)UIView *bjView;

@property(nonatomic, strong) NSArray *list;
@property(nonatomic, strong) NSArray *imageList;

//@property (nonatomic,assign)CGRect beganRect;
@property (nonatomic,assign)CGRect endRect;

@end

@implementation LCAppShowTableView

- (instancetype)showTableViewToView:(UIView *)view endRect:(CGRect)endRect titleArry:(NSArray *)arr imageArry:(NSArray *)imgArr direction:(LCAppShowTableViewDirection)direction{
    return [self showTableViewToView:view endRect:endRect titleArry:arr imageArry:imgArr direction:direction backDirection:direction];
}


- (instancetype)showTableViewToView:(UIView *)view endRect:(CGRect)endRect titleArry:(NSArray *)arr imageArry:(NSArray *)imgArr direction:(LCAppShowTableViewDirection)direction backDirection:(LCAppShowTableViewDirection)backDirection;
{
    self.list = [NSArray arrayWithArray:arr];
    self.imageList = [NSArray arrayWithArray:imgArr];
    self.direction = direction;
    self.backDirection = backDirection;
    self.endRect = endRect;
    
    if (self == [super init]) {
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        UIView *bjView = [[UIView alloc]init];
        bjView.alpha = 0.5;
        bjView.backgroundColor = [UIColor lightGrayColor];
        bjView.layer.cornerRadius = 8.0;
        self.bjView = bjView;
        
        CGFloat padding = 5.0;

        
        UITableView *table = [[UITableView alloc] init];
        self.table = table;
        
        if (direction == LCAppShowTableViewDirectionTop) {
            self.frame = CGRectMake(endRect.origin.x, endRect.origin.y, endRect.size.width, 0)
            ;
            self.table.frame = CGRectMake(padding, padding, endRect.size.width - 2 * padding, 0);
            self.bjView.frame = CGRectMake(0, 0, endRect.size.width, 0);
            
            self.layer.shadowOffset = CGSizeMake(0, padding);

        }else if (direction == LCAppShowTableViewDirectionBottom){
            self.frame = CGRectMake(endRect.origin.x, endRect.origin.y + endRect.size.height, endRect.size.width, 0);
            
            self.table.frame = CGRectMake(padding, padding, endRect.size.width - 2 * padding, 0);
            self.bjView.frame = CGRectMake(0, 0, endRect.size.width, 0);

            self.layer.shadowOffset = CGSizeMake(0, - padding);

        }else if (direction == LCAppShowTableViewDirectionLeft){
            self.frame = CGRectMake(endRect.origin.x, endRect.origin.y, 0, endRect.size.height);
            
            self.table.frame = CGRectMake(padding, padding, 0, endRect.size.height - 2 * padding);
            self.bjView.frame = CGRectMake(0, 0, 0, endRect.size.height);

            self.layer.shadowOffset = CGSizeMake(padding, 0);

        }else if (direction == LCAppShowTableViewDirectionRight){
            self.frame = CGRectMake(endRect.origin.x, endRect.origin.y, 0, endRect.size.height);
            
            self.table.frame = CGRectMake(endRect.size.width - padding, 0, 0, endRect.size.height - 2 * padding);
            self.bjView.frame = CGRectMake(endRect.size.width, 0, 0, endRect.size.height);

            self.layer.shadowOffset = CGSizeMake(- padding,0);

        }else if (direction == LCAppShowTableViewDirectionTopRight){
            self.frame = CGRectMake(endRect.origin.x + endRect.size.width, endRect.origin.y, 0, 0);

//            self.table.frame = CGRectMake(endRect.size.width - padding, 0, 0, 0);
//            self.bjView.frame = CGRectMake(endRect.size.width, 0, 0, 0);
            
            self.layer.shadowOffset = CGSizeMake(- padding,0);
        }
        
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.layer.cornerRadius = 5;
        self.table.backgroundColor = [UIColor whiteColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.table.separatorColor = [UIColor lightGrayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        
        self.frame = endRect;
        self.table.frame = CGRectMake(padding, padding, endRect.size.width - 2 * padding, endRect.size.height - 2 * padding);
        self.bjView.frame = self.bounds;

        [UIView commitAnimations];
        
        [view addSubview:self];
        [self addSubview:bjView];
        [self addSubview:self.table];
    }
    
    return self;
}


- (void)hide{
    CGFloat padding = 5.0;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (self.backDirection == LCAppShowTableViewDirectionTop) {
            self.bjView.frame = CGRectMake(0, 0, self.endRect.size.width, 0);
            self.table.frame = CGRectMake(padding, padding, self.endRect.size.width - 2 * padding, 0);
            
        }else if (self.backDirection == LCAppShowTableViewDirectionBottom){
            self.bjView.frame = CGRectMake(0, self.endRect.size.height, self.endRect.size.width, 0);
            self.table.frame = CGRectMake(padding, self.endRect.size.height - 2 * padding, self.endRect.size.width - 2 * padding, 0);
            
        }else if (self.backDirection == LCAppShowTableViewDirectionLeft){
            self.bjView.frame = CGRectMake(0, 0, 0, self.endRect.size.height);
            self.table.frame = CGRectMake(padding, padding, 0, self.endRect.size.height - 2 * padding);
            
        }else if (self.backDirection == LCAppShowTableViewDirectionRight){
            self.bjView.frame = CGRectMake(self.endRect.size.width, 0, 0, self.endRect.size.height);
            self.table.frame = CGRectMake(self.endRect.size.width - padding, padding, 0, self.endRect.size.height - 2 * padding);
            
        }else if (self.backDirection == LCAppShowTableViewDirectionNone){
            self.bjView.frame = CGRectMake(self.endRect.size.width, 0, 0, 0);
            self.table.frame = CGRectMake(self.endRect.size.width - padding, padding, 0, 0);
            
        }else if (self.backDirection == LCAppShowTableViewDirectionTopRight){
            self.bjView.frame = CGRectMake(self.endRect.size.width, 0, 0, 0);
            self.table.frame = CGRectMake(self.endRect.size.width - padding, padding, 0, 0);
            
        }
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    if ([self.imageList count] == [self.list count]) {
        cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
        cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
    } else if ([self.imageList count] > [self.list count]) {
        cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
        if (indexPath.row < [self.imageList count]) {
            cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.list count]) {
        cell.textLabel.text =[self.list objectAtIndex:indexPath.row];
        if (indexPath.row < [self.imageList count]) {
            cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hide];
#pragma mark - 注释了下面的，不让按钮状态改变
    //    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    //    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    //
    //    for (UIView *subview in btnSender.subviews) {
    //        if ([subview isKindOfClass:[UIImageView class]]) {
    //            [subview removeFromSuperview];
    //        }
    //    }
    //    imgView.image = c.imageView.image;
    //    imgView = [[UIImageView alloc] initWithImage:c.imageView.image];
    //    imgView.frame = CGRectMake(5, 5, 25, 25);
    //    [btnSender addSubview:imgView];
    
    if ([self.delegate respondsToSelector:@selector(showTableViewDelegateMethod: selectedIndex:)]) {
        [self.delegate showTableViewDelegateMethod:self selectedIndex:indexPath.row];
    }
    
}

@end
