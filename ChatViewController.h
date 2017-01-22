//
//  ChatViewController.h
//  MessageFormatter
//
//  Created by Sri Ram on 21/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageComposerView.h"
@interface ChatViewController : UIViewController <MessageComposerViewDelegate, UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) MessageComposerView *messageComposerView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)dismissKeyboard:(id)sender;

@end
