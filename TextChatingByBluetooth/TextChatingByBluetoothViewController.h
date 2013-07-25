//
//  TextChatingByBluetoothViewController.h
//  TextChatingByBluetooth
//
//  Created by ammar falmban on 7/25/13.
//  Copyright (c) 2013 iCSTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TextChatingByBluetoothViewController : UIViewController<GKPeerPickerControllerDelegate,GKSessionDelegate>
// make a property
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (weak, nonatomic) IBOutlet UIButton *connect;
@property (weak, nonatomic) IBOutlet UIButton *disconnect;
@property(nonatomic,retain) GKSession *currentSession;
// make a action
- (IBAction)btnSend:(id)sender;
- (IBAction)btnConnect:(id)sender;
- (IBAction)btnDisconnect:(id)sender;


@end
