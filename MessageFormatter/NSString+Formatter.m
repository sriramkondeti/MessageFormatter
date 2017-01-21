//
//  NSString+Formatter.m
//  MessageFormatter
//
//  Created by Sri Ram on 18/01/2017.
//  Copyright © 2017 Sri Ram. All rights reserved.
//

#import "NSString+Formatter.h"

@implementation NSString (Formatter)

+ (NSString *)formatString:(NSString *)message {
  NSMutableDictionary *contentDict = [NSMutableDictionary dictionary];
  NSMutableArray *linksArray = [NSMutableArray array];
  NSError *error = nil;
  NSDataDetector *detector =
      [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink |
                                            NSTextCheckingTypePhoneNumber
                                      error:&error];
  __block NSInteger offset = 0; // keeps track of range changes in the string
  __block NSString *formattedMessage = message;
  [detector
      enumerateMatchesInString:formattedMessage
                       options:0
                         range:NSMakeRange(0, [formattedMessage length])
                    usingBlock:^(NSTextCheckingResult *_Nullable match,
                                 NSMatchingFlags flags, BOOL *_Nonnull stop) {
                      NSRange resultRange = [match range];
                      resultRange.location += offset; // resultRange.location is updated
                      NSString *replacement = @"************";
                      if ([match resultType] == NSTextCheckingTypePhoneNumber &&
                          match.range.length <= 16) {
                        formattedMessage = [formattedMessage
                            stringByReplacingCharactersInRange:resultRange
                                                    withString:replacement];
                      } else if ([match resultType] == NSTextCheckingTypeLink) {
                        NSURL *url = [match URL];
                        if ([url.absoluteString rangeOfString:@"carlist.my"].location != NSNotFound) {
                          replacement = @"";
                          formattedMessage = [formattedMessage
                              stringByReplacingCharactersInRange:resultRange
                                                      withString:replacement];
                          [linksArray addObject:[[NSMutableDictionary alloc]
                                                    initWithObjectsAndKeys:
                                                        [url absoluteString],
                                                        @"url", nil]];
                        } else {
                          formattedMessage = [formattedMessage
                              stringByReplacingCharactersInRange:resultRange
                                                      withString:replacement];
                        }
                        offset += ([replacement length] - resultRange.length);
                      }
                    }];
  [contentDict setObject:[[NSArray alloc] initWithObjects:formattedMessage, nil] forKey:@"message"];
  if (linksArray.count > 0)
    [contentDict setObject:linksArray forKey:@"Links"];
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDict
                                                     options:0
                                                       error:&error];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
