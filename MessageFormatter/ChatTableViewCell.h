//
//  ChatTableViewCell.h
//  MessageFormatter
//
//  Created by Sri Ram on 21/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property(nonatomic, strong) IBOutlet UILabel *lblMessage;
@property(nonatomic, strong) IBOutlet UIImageView *imbView;
@property(nonatomic, assign) BOOL myBubble;
@end
