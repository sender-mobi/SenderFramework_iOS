//
//  MainConteinerModel.h
//  SENDER
//
//  Created by Eugene on 10/16/14.
//  Copyright (c) 2014 Middleware Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConteinerProtocol.h"
#import "Message.h"
#import "Contact.h"
#import "PBSubviewFacade.h"

typedef enum e_FML_Action{
    
    NONE = 0,
    CallPhone,
    SelectUser,
    RunRobots,
    QrScan,
    ScanQrTo,
    GoToSomeWhere,
    ViewLink,
    SendBtc,
    ShowBtcArhive,
    ShowBtcNotas,
    Share,
    ShowAsQr,
    Copy,
    SubmitOnChange,
    LoadFile,
    ReCryptKey,
    SetGoogleToken,
    Coords,
    ChangeFullVersion
} FML_Action;

@interface MainConteinerModel : NSObject <ConteinerProtocol>
{
    NSString * actionField;
    BOOL autoSubmit;
    NSLock * stringCacheLock;
    NSLock * lockPatternCache;
}

@property (nonatomic, strong) NSArray * submodels;
@property (nonatomic, strong) NSString * className;
@property (strong) NSDate * created;
@property (strong) NSData * data;
@property (nonatomic, weak) NSString * fontStyle;
@property (nonatomic) float fontSize;
@property (nonatomic, strong) NSMutableArray * resultArray;
@property (nonatomic, strong) NSString * procId;
@property (nonatomic, strong) NSString * bitcoinAddress;
@property (nonatomic, strong) PBSubviewFacade * view;
@property (nonatomic, weak) MainConteinerModel * topModel;
@property (nonatomic, strong) Dialog * chat;

- (MainConteinerModel *)initWithMessageData:(Message *)model;
- (NSString *)fontStyle;
- (NSDictionary *)getDataFromModel;
- (FML_Action)detectAction:(NSDictionary *)action_;
- (void)updateView;
- (MainConteinerModel *)findModelWithName:(NSString *)modelName;
- (void)setValue:(NSString *)value forField:(NSString *)fieldName;
- (void)addUser:(Contact *)item forField:(NSString *)field;
- (BOOL)viewHavePadding;
- (BOOL)viewHaveMargins;
- (float)correctHeight;

@end
