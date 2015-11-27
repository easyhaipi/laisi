//
//  MessageViewCell.m
//  LaiSiShop
//
//  Created by taobaichi on 15/11/20.
//  Copyright © 2015年 taobaichi. All rights reserved.
//

#import "MessageViewCell.h"


@interface MessageViewCell()
@property (strong, nonatomic) IBOutlet UILabel *receiverLabel;

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UILabel *senderLabel;

@end

@implementation MessageViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setMessageModel:(MessageModel *)messageModel
{
    _messageModel = messageModel;
    
    
    self.receiverLabel.text = messageModel.receiver;
    self.messageLabel.text = messageModel.message;
    self.senderLabel.text = messageModel.sender;
}
@end
