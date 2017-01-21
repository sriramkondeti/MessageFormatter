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
@interface ChatViewController ()
{
    NSMutableArray *messageArray;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Messages";
    self.messageComposerView = [[MessageComposerView alloc] init];
    self.messageComposerView.delegate = self;
    self.messageComposerView.messagePlaceholder = @"Write a Text with PH.No/URL or Both..";
    self.tableview.layer.contents = (id)[UIImage imageNamed:@"Layer1"].CGImage;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageArray = [[NSMutableArray alloc]initWithObjects:@"Hi Lee, can  you call me at +60175570098",@"You can find the listing at https://www.carlist.my/used-cars/3300445/2011-toyota-vios-1-5-trd-sportivo-33-000km-full-toyota-serviced-record-like-new-11/",@"I have another car at  http://www.example.com/listing10.html", nil];
    [self.view addSubview:self.messageComposerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messageArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   ChatTableViewCell *cell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil)
        cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSData *data = [[NSString formatString:[messageArray objectAtIndex:indexPath.row]] dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    cell.lblMessage.text = [[json objectForKey:@"message"] objectAtIndex:0];
    cell.backgroundColor = [UIColor clearColor];
   UIImage *img = [UIImage imageNamed:@"BubbleOutgoing"];
    cell.imbView.image = [img resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)messageComposerSendMessageClickedWithMessage:(NSString*)message
{
    [messageArray addObject:message];
    [self.tableview reloadData];
   // [self.messageComposerView finishEditing];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
