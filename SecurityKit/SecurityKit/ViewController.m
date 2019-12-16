//
//  ViewController.m
//  SecurityKit
//
//  Created by ZhangLiGuang on 2018/11/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import <Security/Security.h>
#import <CloudKit/CloudKit.h>



#define KRSA_KEY_SIZE 1024
#define KRSA_KEY_SIZE_512 (512)
#define KRSA_KEY_SIZE_256 (256)

@interface ViewController ()
/*!
 * @property
 * @brief 公钥
 */
@property (nonatomic , assign)      SecKeyRef publicKeyRef;
/*!
 * @property
 * @brief 私钥
 */
@property (nonatomic ,  assign)     SecKeyRef privateKeyRef;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self generateRSAKeyPair:KRSA_KEY_SIZE];
    
    
    ///获取默认数据容器，即：iClould.com.cn.CloudKitOrSecurity,该容器与 BoundID 一致，
    CKContainer *myContainer= [CKContainer defaultContainer];
    ///获取公共数据库
    //公有数据库,我建议写成宏
    CKDatabase * publicDataBase = [myContainer publicCloudDatabase];
    
    
    
//    [publicDataBase f]
    
    ///创建一个索引 ID,即：表的 ID
    CKRecordID *artworkRecordID = [[CKRecordID alloc] initWithRecordName:[self returnGenerateTradeNO]];
    
    ///即表明，类似于表名
    CKRecord *artworkRecord = [[CKRecord alloc] initWithRecordType:@"Artwork" recordID:artworkRecordID];
    
    //创建一条记录,type就是模型,与CloudKit 管理后台的Record types 一致,
    //如果后台没有,会自动添加相应的模型或者字段.
//    CKRecord *artworkRecord = [[CKRecord alloc] initWithRecordType:@"Artwork" recordID:artworkRecordID];
    
    //设置模型的数据,和字典用法几乎一样
    artworkRecord[@"name" ] = @"3日游";
    artworkRecord[@"title"] = @"北京人民福音-自贡灯会落户京西古道|周末3日｜京西灯会";
    artworkRecord[@"content"] = @"从启程运输到驿站歇驻，从“琉璃渠”到“窑神庙”……商旅途中的种种场景都将以彩灯的形式再现，将京西古道的盛产与繁荣表现得淋漓尽致。";
    
    
    
    NSString *imageNameStr = [NSString stringWithFormat:@"%@",@"testImage.jpg"];
    UIImage *testImage = [UIImage imageNamed:imageNameStr];
    NSData *imageData = UIImagePNGRepresentation(testImage);
    if (imageData == nil) {
        imageData = UIImageJPEGRepresentation(testImage, 0.6);
    }
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/imagesTemp"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:tempPath]) {
        
        [manager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",tempPath,testImage];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [imageData writeToURL:url atomically:YES];
    NSLog(@"filePath is %@",filePath);
    CKAsset *asset = [[CKAsset alloc]initWithFileURL:url];
    [artworkRecord setValue:asset forKey:@"userPhoto"];


    //私有数据库
    CKDatabase  *privateDatabase = [myContainer privateCloudDatabase];
    
   
    //添加一条记录(这里是添加到公有数据库里面)
    [publicDataBase saveRecord:artworkRecord completionHandler:^(CKRecord *artworkRecord, NSError *error){
        if (!error) {
            //写入成功
            NSLog(@"----Successfull");
        }
        else {
            //写入失败的处理
            NSLog(@"----Failed-----\n%@",error.description);
        }
    }];
    
    
    ///uuidStr------》1950A807-E045-413F-A0E1-FC4B16E00718
    NSUUID *Cuuid = [UIDevice currentDevice].identifierForVendor;
    NSLog(@"uuid 1 = %@",Cuuid.UUIDString);
    ///790EF989-0CDC-47DC-A9DF-EAC3EC35619E
    ///790EF989-0CDC-47DC-A9DF-EAC3EC35619E
    
    
    //自定义的容器,比如上图中的共享容器,需要id标识
    ////获取自定义的容器
    CKContainer *shareContainer = [CKContainer containerWithIdentifier:@"iCloud.com.example.ajohnson.GalleryShared"];
    
    /*
    privateCloudDatabase：奴属于当前手机icloud账户的DB，该账户登录期间，数据提交到该DB里，且只有在该账户登录时，才能取到相关记录。切换icloud账户将无法获取到。
    
    publicCloudDatabase：所有人都可以访问，但只限于同bundleID的 app。（由于container 的bundle ID限制）
    
    sharedCloudDatabase：IOS10新推出的，用 CKShare 创建的记录，设定一定的权限 即可被遵守相同规则的 app访问到。
    */
}

-(NSString *)returnGenerateTradeNO
{
    const int N = 30;
    
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand((unsigned)time(0));
    for (int i = 0; i < N; i++)
    {
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    
    return [NSString stringWithFormat:@"SK%@",result];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//生成RSA密钥对，公钥和私钥，支持的SIZE有
// sizes for RSA keys are: 512, 768, 1024, 2048.
- (void)generateRSAKeyPair:(int )keySize{
    OSStatus ret = 0;
    self.publicKeyRef = NULL;
    self.privateKeyRef = NULL;
    ret = SecKeyGeneratePair((CFDictionaryRef)@{(id)kSecAttrKeyType:(id)kSecAttrKeyTypeRSA,(id)kSecAttrKeySizeInBits:@(keySize)}, &_publicKeyRef, &_privateKeyRef);
    
    NSLog(@"OSStatus is %ld",(int)ret);
    
    NSLog(@"\n%@",self.publicKeyRef);
    NSLog(@"\n%@",self.privateKeyRef);
    NSLog(@"\nmax size:%lu",SecKeyGetBlockSize(self.privateKeyRef));
}












@end
