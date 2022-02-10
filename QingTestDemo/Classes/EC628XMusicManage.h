//
//  EC628XMusicManage.h
//  EC628Set
//
//  Created by Ogawa on 2021/12/6.
//  Copyright © 2021 HLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,JingLuoMusicType) {
    ///检测开始
    JingLuoMusicTypeStar = 0,
    ///检测结束
    JingLuoMusicTypeEnd,
    ///检测失败
    JingLuoMusicTypeFail,
    ///检测关闭
    JingLuoMusicTypeClose,
    ///手指1
    JingLuoMusicTypeFinger1,
    ///手指2
    JingLuoMusicTypeFinger2,
    ///手指3
    JingLuoMusicTypeFinger3,
    ///手指4
    JingLuoMusicTypeFinger4,
    ///手指5
    JingLuoMusicTypeFinger5,
    ///手指6
    JingLuoMusicTypeFinger6,
    ///手指7
    JingLuoMusicTypeFinger7,
    ///手指8
    JingLuoMusicTypeFinger8,
    ///手指9
    JingLuoMusicTypeFinger9,
    ///手指10
    JingLuoMusicTypeFinger10,
};

@interface EC628XMusicManage : NSObject <AVAudioPlayerDelegate>
{
    AVAudioPlayer* _player;
}

+ (instancetype)shareInstance;

- (void)startPlayerWithType:(JingLuoMusicType)type;

- (void)stopPlayer;

@end

NS_ASSUME_NONNULL_END
