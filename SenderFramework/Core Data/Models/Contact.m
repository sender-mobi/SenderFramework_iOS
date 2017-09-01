//
//  Contact.m
//  SENDER
//
//  Created by Eugene Gilko on 9/10/15.
//  Copyright (c) 2015 Middleware Inc. All rights reserved.
//

#import "Contact.h"
#import "BarModel.h"
#import "Dialog.h"
#import "Item.h"
#import "CoreDataFacade.h"
#import "DefaultContactImageGenerator.h"
#import "ServerFacade.h"
#import "SenderNotifications.h"
#import "ParamsFacade.h"
#import "BarItem.h"
#import "Message.h"
#import "PBConsoleConstants.h"
#import "NS+BTCBase58.h"
#import "Owner.h"

#import <libPhoneNumber_iOS/NBPhoneNumberUtil.h>

@implementation Contact

@dynamic contactDescription;
@dynamic imageURL;
@dynamic isOnline;
@dynamic msgKey;
@dynamic name;
@dynamic userID;
@dynamic items;
@dynamic bitcoinAddress;
@dynamic localID;
@dynamic p2pChat;
@synthesize lastOnlineCallTime;
@synthesize cellBackgroundColor = _cellBackgroundColor;

-(UIColor *)cellBackgroundColor
{
    if (!_cellBackgroundColor)
        _cellBackgroundColor = [[SenderCore sharedCore].stylePalette randomColor];
    return _cellBackgroundColor;
}

- (NSString *)getPhoneFormatted:(BOOL)formatted
{
    NSString * returnPhone = @"";
    
    Item * item = [self getSomeItem];
    
    if(item.value)
    {
        if([item.type isEqualToString:@"phone"])
        {
            returnPhone = item.value;
            
            if (formatted)
            {
                NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
                NSError *error = nil;
                NBPhoneNumber *myNumber;
                
                myNumber = [phoneUtil parse:[item.value hasPrefix:@"+"] ? item.value : [@"+" stringByAppendingString:item.value]
                              defaultRegion:@"UA" error:&error];
                
                if (error == nil)
                    returnPhone = [phoneUtil format:myNumber numberFormat: NBEPhoneNumberFormatINTERNATIONAL error:&error];
            }
        }
    }
    
    return returnPhone;
}

- (Item *)getSomeItem
{
    if(self.items && self.items.count)
    {
        NSArray * phones = self.items.allObjects;
        NSArray * res = [phones filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"type == %@", @"phone"]];
        if (res.count) {
            return res[0];
        }
        else
        {
            return phones[0];
        }
    }
    else
    {
        return nil;
    }
}

- (NSString *)getDefaultImageName
{
    return [DefaultContactImageGenerator convertContactNameToImageName:self.name];
}

- (void)addPhone:(NSString *)phone
{
    Item * new = (Item *)[[CoreDataFacade sharedInstance] getNewObjectWithName:@"Item"];
    new.value = phone;
    new.type = @"phone";
    [self addItemsObject:new];
}

- (void)prepareForDeletion
{
    if (self.p2pChat)
        [self.p2pChat.managedObjectContext deleteObject:self.p2pChat];
}

@end
