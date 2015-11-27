//
//  HistoryMessageViewController.m
//  LaiSiShop
//
//  Created by taobaichi on 15/11/20.
//  Copyright © 2015年 taobaichi. All rights reserved.
//

#import "HistoryMessageViewController.h"
#import "FMDatabase.h"

#import "MessageModel.h"
#import "MessageViewCell.h"
@interface HistoryMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *modelArray;
@end

@implementation HistoryMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

    self.title = @"历史消息";

    
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"SELECT * FROM Message";
        FMResultSet *rs  = [db executeQuery:sql];
        NSMutableArray *temArray = [NSMutableArray array];
        while ([rs next]) {
//            receiver,message,sender
            MessageModel *model = [[MessageModel alloc] init];
            model.msgId = [rs intForColumn:@"id"];
            model.message = [rs stringForColumn:@"message"];
            model.receiver = [rs stringForColumn:@"receiver"];
            model.sender = [rs stringForColumn:@"sender"];
            
            
            [temArray addObject:model];
            
          
        }
          [db close];
        self.modelArray = temArray;
        
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ----tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"MessageViewCell";
    MessageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageViewCell" owner:nil options:nil]lastObject];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    
    
    MessageModel *model = (MessageModel *)[self.modelArray objectAtIndex:indexPath.row];
  
    cell.messageModel = model;
    return cell;
}
@end
