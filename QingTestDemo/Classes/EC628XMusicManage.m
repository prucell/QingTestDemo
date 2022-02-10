//
//  EC628XMusicManage.m
//  EC628Set
//
//  Created by Ogawa on 2021/12/6.
//  Copyright © 2021 HLin. All rights reserved.
//

#import "EC628XMusicManage.h"

@interface EC628XMusicManage ()

@property (nonatomic,strong) NSArray <NSString *>*musicArray;

@end

@implementation EC628XMusicManage


+ (instancetype)shareInstance
{
    static EC628XMusicManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [EC628XMusicManage new];
    });
    return manage;
}

- (void)createMusicPlay
{
    if (_player && [_player isPlaying]) {
        return;
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [[AVAudioSession sharedInstance] setMode:AVAudioSessionModeDefault error:nil];

    NSString* route = [[[[[AVAudioSession sharedInstance] currentRoute] outputs] objectAtIndex:0] portType];
    
    if ([route isEqualToString:AVAudioSessionPortHeadphones] || [route isEqualToString:AVAudioSessionPortBluetoothA2DP] || [route isEqualToString:AVAudioSessionPortBluetoothLE] || [route isEqualToString:AVAudioSessionPortBluetoothHFP]) {
        if (@available(iOS 10.0, *)) {
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                             withOptions:(AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionAllowBluetooth | AVAudioSessionCategoryOptionAllowBluetoothA2DP)
                                                   error:nil];
        } else {
            // Fallback on earlier versions
        }
    }else{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                         withOptions:(AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDefaultToSpeaker)
                                               error:nil];
    }
    
    [session setActive:YES error:nil];
}

- (void)startPlayerWithType:(JingLuoMusicType)type
{
    if (type > self.musicArray.count-1) {
        return;
    }
    
    NSString *musicName = self.musicArray[type];
    NSString *path = [[NSBundle mainBundle]pathForResource:musicName ofType:@"mp3"];
    NSError *error = nil;
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    _player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    [_player prepareToPlay];
    [_player setDelegate:self];
    _player.numberOfLoops = 0;
    BOOL ret = [_player play];
    if (!ret) {
        NSLog(@"play failed,please turn on audio background mode");
    }
}

- (void)stopPlayer
{
    if (_player) {
        [_player stop];
        _player = nil;
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:NO error:nil];
        NSLog(@"stop in play background success");
    }
}




#pragma mark -- delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    ///结束
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0)
{
    
}

#pragma mark -- set
- (NSArray<NSString *> *)musicArray
{
    if (!_musicArray) {
        _musicArray = @[@"jingluo_start",@"jingluo_end",@"jingluo_error",@"jingluo_close",@"finger_1",@"finger_2",@"finger_3",@"finger_4",@"finger_5",@"finger_6",@"finger_7",@"finger_8",@"finger_9",@"finger_10"];
    }
    return _musicArray;
}

@end
