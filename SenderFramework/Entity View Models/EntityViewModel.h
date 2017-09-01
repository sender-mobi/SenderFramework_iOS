//
//  ChatCellModel.h
//  SENDER
//
//  Created by Eugene Gilko on 11/5/15.
//  Copyright © 2015 Middleware Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
#import "Dialog.h"
#import "CoreDataFacade.h"

@protocol EntityViewModel <NSObject>

@required

@property (nonatomic, strong, readonly) NSString * chatTitle;
@property (nonatomic, strong, readonly) NSString * chatTitleLatin;
@property (nonatomic, strong, readonly) NSString * chatSubtitle;

@property (nonatomic, readonly) NSInteger unreadCount;
@property (nonatomic, readonly) ChatType chatType;
@property (nonatomic, strong, readonly) NSDate * lastMessageTime;

@property (nonatomic, readonly) BOOL isFavorite;
@property (nonatomic, readonly) BOOL isEncrypted;
@property (nonatomic, readonly) BOOL isCounterHidden;
@property (nonatomic, readonly) BOOL isNotificationsHidden;

@property (nonatomic, strong, readonly) NSURL * imageURL;
@property (nonatomic, readonly) UIColor * imageBackgroundColor;

@property (nonatomic, strong, readonly) UIColor * defaultImageBackgroundColor;
@property (nonatomic, strong, readonly) UIImage * defaultImage;

@end

