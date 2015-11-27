//
//  NewDataViewController.m
//  LaiSiShop
//
//  Created by taobaichi on 15/11/20.
//  Copyright © 2015年 taobaichi. All rights reserved.
//

#import "NewDataViewController.h"

#import "FMDatabase.h"

#import "MBProgressHUD+MJ.h"

#import "HistoryMessageViewController.h"
@interface NewDataViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSString *dbPath;
@property (strong, nonatomic) IBOutlet UITextField *receiveTextField;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UITextField *sendTextField;
- (IBAction)sendAction:(UIButton *)sender;


@end



@implementation NewDataViewController
- (NSString *) dbPath//应用程序的沙盒路径

{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *document = [path objectAtIndex:0];
    
    return [document stringByAppendingPathComponent:@"MeaaageDB.sqlite"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchEndEdit)];
    [self.view addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)touchEndEdit
{
    NSLog(@"=========");
    
    
    
    [self.receiveTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];
    [self.sendTextField resignFirstResponder];
}



#pragma mark ----发送
- (IBAction)sendAction:(UIButton *)sender {
    
    // 创建数据库表
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'Message' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'receiver' CHAR(30), 'message' CHAR(100),'sender' CHAR(30))";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"succ to creating db table");
        }
        [db close];
    } else {
        NSLog(@"error when open db");
    }

    
    
    
 
    if ([db open]) {
        NSString *sql = @"insert INTO Message(receiver,message,sender)VALUES (?,?,?)";

        if (!self.receiveTextField.text.length) {
            [MBProgressHUD showError:@"请输入收件人"];
            return;
        } else if (!self.messageTextField.text.length){
            [MBProgressHUD showError:@"请输入内容"];
              return;
        } else if (!self.sendTextField.text.length){
            [MBProgressHUD showError:@"请输入发送人"];
              return;
        }
        BOOL res = [db executeUpdate:sql,self.receiveTextField.text,self.messageTextField.text,self.sendTextField.text];
        
        if (res) {
            NSLog(@"插入数据成功");
            [MBProgressHUD showSuccess:@"发送成功"];
        }else{
            NSLog(@"插入数据失败");
        }
        [db close];
    } else{
        NSLog(@"打开数据库失败");
    }
    
    

    
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"history"]) {
        
        HistoryMessageViewController  *history = (HistoryMessageViewController *)segue.destinationViewController;
        history.dbPath = self.dbPath;
//        segue.destinationViewController.
        
    }
}


@end
