//
//  TextChatingByBluetoothViewController.m
//  TextChatingByBluetooth
//
//  Created by ammar falmban on 7/25/13.
//  Copyright (c) 2013 iCSTH. All rights reserved.
//

#import "TextChatingByBluetoothViewController.h"
#import <GameKit/GameKit.h>

@interface TextChatingByBluetoothViewController ()

@end

@implementation TextChatingByBluetoothViewController
// make a setter and getter
@synthesize connect;
@synthesize disconnect;
@synthesize currentSession;
@synthesize txtMessage;
//
GKPeerPickerController *picker;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [connect    setHidden:NO];
    [disconnect setHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Define the btnSend: method as follows so that the text entered by the user will be sent to the remote device
- (IBAction)btnSend:(id)sender {
    // -- convert an NSString object o NSData
    NSData   *data;
    NSString *str = [NSString stringWithString:txtMessage.text];
    data = [str dataUsingEncoding:NSASCIIStringEncoding];
    [self mySendDataToPeers:data];
    
}

- (IBAction)btnConnect:(id)sender {

    picker = [[GKPeerPickerController alloc]init];
    picker.delegate = self;
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [connect setHidden:YES];
    [disconnect setHidden:NO];
    [picker show];

}
- (IBAction)btnDisconnect:(id)sender {
    [self.currentSession disconnectFromAllPeers];
    currentSession = nil;
    [connect    setHidden:NO];
    [disconnect setHidden:YES];
}
// When remote Bluetooth devices are detected and the user has selected and connected to one of them
-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    
    self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    picker.delegate = nil;
    [picker dismiss];
    
    
}
// When the user has connected to the peer Bluetooth device, you save the GKSession object to the currentSession property. This will allow you to use the GKSession object to communicate with the remote device.
-(void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
    picker.delegate = nil;
    [connect    setHidden:NO];
    [disconnect setHidden:YES];
}
//To disconnect from a connected device, use the disconnectFromAllPeers method from the GKSession object
-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
   
    switch(state) {
        case GKPeerStateConnected:
            NSLog(@"يا هلا ");
            break;
        case GKPeerStateDisconnected:
            NSLog(@"غبر متصل");
            currentSession = nil;
            [connect    setHidden:NO];
            [disconnect setHidden:YES];
            break;
    default:
            NSLog(@"Salam");
            break;
    }
}
//To send data to the connected Bluetooth device, use the sendDataToAllPeers: method of the GKSession object.
-(void)mySendDataToPeers:(NSData *)data{
    
    if(currentSession)
       [self.currentSession sendDataToAllPeers:data
                                  withDataMode:GKSendDataReliable
                                         error:nil];
    
}
//When data is received from the other device, the receiveData:fromPeer:inSession:context: method will be called.
-(void)receiveData:(NSData *)data
          fromPeer:(NSString *)peer
         inSession:(GKSession *)session
           context:(void *)context{
    // -- convert NSData to NSString
    
    NSString *str = [[NSString alloc]
                     initWithData:data encoding:NSASCIIStringEncoding];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"تم الاستلام " message:str delegate:self cancelButtonTitle:@"تم" otherButtonTitles:nil];
    [alert show];
    
}
@end
