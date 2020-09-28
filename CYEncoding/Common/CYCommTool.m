//
//  CYCommTool.m
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import "CYCommTool.h"

#pragma mark - 打印

/*
 * groupNum: 位分组数，如传6，则6位为一组
 * sectionNum: 组分段数，如传3，则3组为一段
 */
void cytLogData_2s_format(NSData *data, int groupNum, int sectionNum) {
   
    int groupCount = 0;
    int sectionCount = 0;
    
    unsigned char *pData = (unsigned char *)data.bytes;
    for (int i = 0; i < data.length; i++) {
        
        unsigned char curVal = pData[i];
        for (int j = 7; j >= 0; j--) {
            printf("%d", (curVal >> j) % 2);
            
            groupCount++;
            if (0 == groupCount % groupNum) {
                printf(" ");
                
                sectionCount++;
                if (0 == sectionCount % sectionNum) {
                    printf("\n");
                }
            }
        }
    }
    
    printf("\n");
}

void cytLogData_2s(NSData *data) {
    cytLogData_2s_format(data, 8, 99999);
}

// 打印 NSData 的 10进制数据
void cytLogData_10s(NSData *data) {
    
    unsigned char *pData = (unsigned char *)data.bytes;
    for (int i = 0; i < data.length; i++) {
        printf("%02u ", (int)pData[i]);
    }
    
    printf("\n");
}

void cytLogData_16s(NSData *data) {
    
    unsigned char *pData = (unsigned char *)data.bytes;
    for (int i = 0; i < data.length; i++) {
        printf("%02x ", pData[i]);
    }
    
    printf("\n");
}

#pragma mark - UTF-8

void cytLogStringData(NSString *inputStr, NSStringEncoding encoding) {
             
    for (int i = 0; i < inputStr.length; i++) {
        NSString *tmpStr = [inputStr substringWithRange:NSMakeRange(i, 1)];
        NSData *tmpData = [tmpStr dataUsingEncoding:encoding];
        printf("%s : %d\n", tmpStr.UTF8String, (int)tmpData.length);
        cytLogData_16s(tmpData);
        cytLogData_2s(tmpData);
        printf("\n");
    }

    NSData *inputData = [inputStr dataUsingEncoding:encoding];
    cytLogData_16s(inputData);
    cytLogData_2s(inputData);
    printf("字符数：%d \n字节数：%d \n每个字符平均占用： %.2f字节\n",
          (int)inputStr.length,
          (int)inputData.length,
          (float)inputData.length / inputStr.length);
}

#pragma mark - Base64

static unsigned char __char2base64Index(unsigned char asciiVal) {
    
    if (asciiVal >= 'A' && asciiVal <= 'Z') {
        return asciiVal - 'A';
    }
    
    else if (asciiVal >= 'a' && asciiVal <= 'z') {
        return asciiVal - 'a' + 26;
    }

    else if (asciiVal >= '0' && asciiVal <= '9') {
        return asciiVal - '0' + 52;
    }
    
    else if (asciiVal == '+') {
        return 62;
    }
    
    else if (asciiVal == '/') {
        return 63;
    }

    return 0;
}

/* base64 + utf8 binary data --> base64 index binary data */
NSData * __base64utf8Data_2_base64IndexData(NSData *base64Utf8Data) {
    
    NSMutableData *tmpMulData = [[NSMutableData alloc] init];
    
    unsigned char *pData = (unsigned char *)base64Utf8Data.bytes;
    for (int i = 0; i < base64Utf8Data.length; i++) {
        unsigned char origVal = __char2base64Index(pData[i]);
        [tmpMulData appendBytes:&origVal length:1];
    }
    
    return tmpMulData.copy;
}

// 打印base64的编码流程
void cytLogStringData_base64_flow(NSString *inputStr) {
    
    NSData *inputData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64InputData = [inputData base64EncodedDataWithOptions:0];
    NSString *base64InputStr = [[NSString alloc] initWithData:base64InputData encoding:NSUTF8StringEncoding];
    NSData *base64OrigInputData = __base64utf8Data_2_base64IndexData(base64InputData);
    
    /* 1 输入字符串 */
    printf("1 输入字符串: \n");
    printf("%s\n\n", inputStr.UTF8String);
    
    /* 2 将字符串转为数据(通过UTF-8)编码 */
    printf("2 将字符串转为数据(通过UTF-8)编码:\n");
    printf("16进制数据表示: ");cytLogData_16s(inputData);
    printf("2进制数据表示: ");cytLogData_2s(inputData);
    printf("\n");
    
    /* 3 将2进制数据3字节分组 */
    printf("3 将2进制数据进行3字节分组:\n");
    cytLogData_2s_format(inputData, 8, 3);
    printf("\n");
    
    /* 4 将每三个字节分为4组 */
    printf("4 将2进制数据每3个字节分为4组:\n");
    cytLogData_2s_format(inputData, 6, 4);
    printf("\n");
    
    /* 5 获取base64编码的索引值 */
    printf("5 获取base64编码的索引值:\n");
    cytLogData_10s(base64OrigInputData);
    printf("\n");
    
    /* 6 将索引映射为base64目标字符 */
    printf("6 将索引映射为base64目标字符:\n");
    printf("%s\n", base64InputStr.UTF8String);
    printf("\n");
    
    /* 7 base64字符串内存中的样子(对应字符的ASCII值，或说utf-8编码值) */
    printf("7 base64字符串内存中的样子(对应字符的ASCII值，或说utf-8编码值):\n");
    cytLogData_2s(base64InputData);
}



