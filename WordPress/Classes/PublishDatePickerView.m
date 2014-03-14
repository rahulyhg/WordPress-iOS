//
//  PublishDatePickerView.m
//  WordPress
//
//  Created by Eric Johnson on 3/12/14.
//  Copyright (c) 2014 WordPress. All rights reserved.
//

#import "PublishDatePickerView.h"

@implementation PublishDatePickerView

- (NSArray *)buttonsForToolbar {
    NSMutableArray *arr = [[super buttonsForToolbar] mutableCopy];
    
    NSString *title = NSLocalizedString(@"Publish Immediately", @"Post publishing status in the Post Editor/Settings area (compare with WP core translations).");
    UIBarButtonItem *publishButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(publishImmeidately)];
    [arr replaceObjectAtIndex:0 withObject:publishButton];
    
    return arr;
}

- (void)publishImmeidately {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didFinishWithValue:)]) {
        [self.delegate pickerView:self didFinishWithValue:nil];
    }
}


@end
