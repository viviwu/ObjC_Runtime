//
//  NSString+X.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "NSString+X.h"

@implementation NSString (X)

- (NSArray<NSString*>*)tokenizerUnitWord
{
  NSMutableArray * tokenizerUnitWord = [NSMutableArray array];
  CFStringTokenizerRef tokenizerRef = CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)self, CFRangeMake(0, self.length), kCFStringTokenizerUnitWord, NULL);
  CFStringTokenizerAdvanceToNextToken(tokenizerRef);
  CFRange range = CFStringTokenizerGetCurrentTokenRange(tokenizerRef);
  
  NSString * unitWord = nil;
  while (range.length>0) {
    unitWord = [self substringWithRange:NSMakeRange(range.location, range.length)];
    [tokenizerUnitWord addObject:unitWord];
    CFStringTokenizerAdvanceToNextToken(tokenizerRef);
    range = CFStringTokenizerGetCurrentTokenRange(tokenizerRef);
  }
  return tokenizerUnitWord;
}

@end
