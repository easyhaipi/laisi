//
//  MessageModel.h
//  LaiSiShop
//
//  Created by taobaichi on 15/11/20.
//  Copyright © 2015年 taobaichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(nonatomic,strong)NSString *receiver;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *sender;

@property(nonatomic,assign) int msgId;


@end
