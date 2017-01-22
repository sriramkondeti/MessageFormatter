//
//  ChatViewController.m
//  MessageFormatter
//
//  Created by Sri Ram on 21/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "NSString+Formatter.h"
@interface ChatViewController () {
  NSMutableArray *messageArray;//To Save Default and New Messages.
}
@end

@implementation ChatViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  //Setup MessageComposer
  self.title = @"Messages";
  self.messageComposerView = [[MessageComposerView alloc] init];
  self.messageComposerView.delegate = self;
  self.messageComposerView.messagePlaceholder =
      @"Enter a Text with PH.No/URL/Email/All";
  self.tableview.layer.contents = (id)[UIImage imageNamed:@"Layer1"].CGImage;
  self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //Init with test objects from Assesment Given.
  messageArray = [[NSMutableArray alloc] initWithObjects:
          @"Hi Lee, can  you call me at +60175570098",
          @"You can find the listing at https://www.carlist.my/used-cars/3300445/2011-toyota-vios-1-5-trd-sportivo-33-000km-full-toyota-serviced-record-like-new-11/",
          @"I have another car at  http://www.example.com/listing10.htm", nil];
  [self.view addSubview:self.messageComposerView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView
    estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 44;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Custom Cell Implementation
  ChatTableViewCell *cell = (ChatTableViewCell *)[tableView
      dequeueReusableCellWithIdentifier:@"cell"
                           forIndexPath:indexPath];
  if (cell == nil)
    cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"cell"];
    //Call the Custom NSString Categroy, Returns Json String as Per the Requirement.
  NSData *data = [[NSString formatString:[messageArray objectAtIndex:indexPath.row]]
          dataUsingEncoding:NSUTF8StringEncoding];
  id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  cell.lblMessage.text = [[dict objectForKey:@"message"] objectAtIndex:0];
  cell.backgroundColor = [UIColor clearColor];
  UIImage *img = [UIImage imageNamed:@"BubbleOutgoing"];
  cell.imbView.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)
                          resizingMode:UIImageResizingModeStretch];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

#pragma mark - Messsage Composer Delegate

- (void)messageComposerSendMessageClickedWithMessage:(NSString *)message {
  [messageArray addObject:message];//Add Object to Message Array.
  [self.tableview reloadData];//Reload Table.
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.messageComposerView finishEditing];
}
@end
