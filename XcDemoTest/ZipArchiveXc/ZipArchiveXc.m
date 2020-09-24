//
//  ZipArchiveXc.m
//  XcDemoTest
//
//  Created by shiran on 2020/9/23.
//

#import "ZipArchiveXc.h"
#import <ZipArchive/ZipArchive.h>
#import <SSZipArchive/SSZipArchive.h>

@interface ZipArchiveXc ()

@end

@implementation ZipArchiveXc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
    ziparchive 是基于开源代码 MiniZip 的 zip 压缩与解压的 Objective-C 的 Class, 使用起来非常的简单
    SDK 获取：从 http://code.google.com/p/ziparchive/ 上 下载 ZipArchive.zip 解压后将代码加入工程中 ，并且把 zlib 库添加到工程中
    使用方法：1. 压缩: ZipArchive 可以压缩多个文件, 只需要把文件 一 一 addFileToZip 即可.
    
     */
    
    
   
    
    
}

- (void)addFileToZip {
    
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *l_zipfile = [documentpath stringByAppendingString:@"/test.zip"] ;
       
    NSString *image1 = [documentpath stringByAppendingString:@"/image1.jpg"] ;
    NSString *image2 = [documentpath stringByAppendingString:@"/image2.jpg"] ;
       
    BOOL ret = [zip CreateZipFile2:l_zipfile];
    ret = [zip addFileToZip:image1 newname:@"image1.jpg"];
    ret = [zip addFileToZip:image2 newname:@"image2.jpg"];
    
    if( ![zip CloseZipFile2] ) {
        l_zipfile = @"";
    }
    
    // [zip release];
    
    
    
}


// 解压缩:
- (void)UnzipFileTo {
    
    ZipArchive* zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString* l_zipfile = [documentpath stringByAppendingString:@"/test.zip"] ;
   
    NSString* unzipto = [documentpath stringByAppendingString:@"/test"] ;
    
    if( [zip UnzipOpenFile:l_zipfile] ) {
       BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
       if( NO == ret ) {
       }
       [zip UnzipCloseFile];
     }
    
    // [zip release];
    
    
    /**
    
    二、压缩包含中文的文件时，到 windows 下解压后出现 乱码。
    这个问题原因是 iOS 版本的 ZipArchive 工程中，编码格式变为 UTF-8. 然后 windows 上的编码格式多数是 GBK。
    那么打开 ZipArchive 的源码，改变编码方式就行了。
    找到函数：
    -(BOOL) addFileToZip:(NSString*) file newname:(NSString*) newname {
    if( [_passwordlength] ==0 ) {
        
    ret = zipOpenNewFileInZip(_zipFile, (constchar*) [newnameUTF8String],// UTF-8方式编码
    &zipInfo,NULL,0,NULL,0,
    NULL,//comment
    Z_DEFLATED, Z_DEFAULT_COMPRESSION );
    }
    }

    将上述代码中划线部分，替换为下面部分即可。
    (constchar*) [newnamecStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)],

    已经在 mac 和 windows 两端测试通过，都可以正常压缩带有中文的文件，并能正常解压。

     
    三、解压带有中文或者日文的压缩文件问题
    原因是：ZipArchive 类的解压函数
    -(BOOL) UnzipFileTo:(NSString*) path overWrite:(BOOL) overwrite
    在遍历压缩文件包，获取包文件的名字处理上存在 Bug.

    1.下面两行代码获取包中当前文件的文件名
        unzGetCurrentFileInfo(_unzFile, &fileInfo, filename, fileInfo.size_filename + 1, NULL, 0, NULL, 0);
        filename[fileInfo.size_filename] = '\0';  //未尾追加0 结束
    此时获取的文件名是正确的.

    2. 但是由 char* 获取得到 NSString* 的转换方法使用出错，Mac 默认是按 UTF8 编码的
    // NSString * strPath = [NSString  stringWithCString:filename];   //此处得到的 strPath为空，导致函数返回YES，但目录下无文件

    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString * strPath = [NSString  stringWithCString:filename encoding:enc];//正确！这个地方应该是跟压缩时的编码对应上才对。
    这样就OK了！
    
     */
    
}

/**
 
SSZipArchive
1.简介
SSZipArchive 是 iOS 和 Mac 上一个简单实用的压缩和解压插件 。
用途包括：
1.解压zip文件；
2.解压密码保护的ZIP文件；
3.创建新的zip文件；
4.追加文件到现有的压缩；
5.压缩文件；
6.压缩NSData（带有文件名）

SSZipArchive的GitHub地址：https://github.com/ZipArchive/ZipArchive

*/

// 2.压缩方法 压缩指定文件代码：
/**
 *  SSZipArchive压缩
 */
-(void)ssZipArchiveWithFiles {
    // Caches路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    // zip压缩包保存路径
    NSString *path = [cachesPath stringByAppendingPathComponent:@"SSZipArchive.zip"];
    // 需要压缩的文件
    NSArray *filesPath = @[
                          @"/Users/apple/Desktop/demo/LaunchImage-2-700-568h@2x.png",
                          @"/Users/apple/Desktop/demo/LaunchImage-2-700@2x.png",
                          @"/Users/apple/Desktop/demo/LaunchImage-2-800-667h@2x.png",
                          @"/Users/apple/Desktop/demo/LaunchImage-2-800-Landscape-736h@3x.png"
                          ];
    //创建不带密码zip压缩包
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath];
    //创建带密码zip压缩包
    //BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath withPassword:@"SSZipArchive.zip"];
}
 

// 压缩指定文件夹代码：
/**
 *  SSZipArchive压缩
 */
-(void)ssZipArchiveWithFolder {
    // Caches路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    // zip压缩包保存路径
    NSString *path = [cachesPath stringByAppendingPathComponent:@"SSZipArchive.zip"];
    //需要压缩的文件夹路径
    NSString *folderPath = @"/Users/apple/Desktop/demo/";
    //创建不带密码zip压缩包
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withContentsOfDirectory:folderPath ];
    //创建带密码zip压缩包
    //BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withContentsOfDirectory:folderPath withPassword:@"SSZipArchive.zip"];
}


// 3.解压方法 代码：
/**
 *  SSZipArchive解压
 */
-(void)uSSZipArchive {
    //Caches路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //解压目标路径
    NSString *destinationPath =[cachesPath stringByAppendingPathComponent:@"SSZipArchive"];
    //zip压缩包的路径
    NSString *path = [cachesPath stringByAppendingPathComponent:@"SSZipArchive.zip"];
    //解压
    BOOL isSuccess = [SSZipArchive unzipFileAtPath:path toDestination:destinationPath];
}


// 二、ZipArchive
// 1.简介 ZipArchive可以解压和压缩
// 2.压缩方法 代码：
 /**
  *  ZipArchive压缩
  */
-(void)zipArchiveWithFiles {
     //创建解压缩对象
     ZipArchive *zip = [[ZipArchive alloc]init];
     //Caches路径
     NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
     //zip压缩包保存路径
     NSString *path = [cachesPath stringByAppendingPathComponent:@"ZipArchive.zip"];//创建不带密码zip压缩包12　　　//创建zip压缩包
     [zip CreateZipFile2:path];
     //创建带密码zip压缩包
     //[zip CreateZipFile2:path Password:@"ZipArchive.zip"];
     //添加到zip压缩包的文件
     [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-700-568h@2x.png" newname:@"1.png"];
     [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-700@2x.png" newname:@"2.png"];
     [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-800-667h@2x.png" newname:@"3.png"];
     [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-800-Landscape-736h@3x.png" newname:@"4.png"];
     //关闭压缩
     BOOL success = [zip CloseZipFile2];
 }

// 3.解压方法 代码：

/**
 *  ZipArchive解压
 */
-(void)uZipArchive {
    //创建解压缩对象
    ZipArchive *zip = [[ZipArchive alloc]init];
    //Caches路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //解压目标路径
    NSString *savePath =[cachesPath stringByAppendingPathComponent:@"ZipArchive"];
    //zip压缩包的路径
    NSString *path = [cachesPath stringByAppendingPathComponent:@"ZipArchive.zip"];
    //解压不带密码压缩包
    [zip UnzipOpenFile:path];
    //解压带密码压缩包
    //[zip UnzipOpenFile:path Password:@"ZipArchive.zip"];
    //解压
    [zip UnzipFileTo:savePath overWrite:YES];
    //关闭解压
    BOOL success = [zip UnzipCloseFile];
}






@end
