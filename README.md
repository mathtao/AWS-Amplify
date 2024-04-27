# AWS-Amplify
基于AWS Amplify人脸识别



1、不是通过CLI生成key文件进行授权，而是本地设置key字符串进行调试

2、单独调试人脸比对可用aws  amplify这个库，得到数据

```json
{
                     "SessionId": "75c1ec93-28b1-4076-a5b5-8ef74ae396c8",
                     "Status": "SUCCEEDED",
                     "Confidence": 91.72110748291016,
                     "ReferenceImage": {
                         "Bytes": "/9j/4AAQSkZJRgAB...",
                         "BoundingBox": {
                             "Width": 260.81927490234375,
                             "Height": 375.1768798828125,
                             "Left": 188.30845642089844,
                             "Top": 94.32212829589844
                         }
                     },
                     "AuditImages": [
                         {
                             "Bytes": "/9j/4AAQSkZJRgAB...",
                             "BoundingBox": {
                                 "Width": 162.59634399414062,
                                 "Height": 241.1438751220703,
                                 "Left": 281.1000061035156,
                                 "Top": 134.10536193847656
                             }
                         },
                         {
                             "Bytes": "/9j/4AAQSkZJRgAB...",
                             "BoundingBox": {
                                 "Width": 221.2363739013672,
                                 "Height": 330.3712158203125,
                                 "Left": 199.21690368652344,
                                 "Top": 87.85931396484375
                             }
                         },
                         {
                             "Bytes": "/9j/4AAQSkZJRgAB...",
                             "BoundingBox": {
                                 "Width": 279.0862121582031,
                                 "Height": 393.36517333984375,
                                 "Left": 176.24908447265625,
                                 "Top": 97.81661224365234
                             }
                         },
                         {
                             "Bytes": "/9j/4AAQSkZJRgAB...",
                             "BoundingBox": {
                                 "Width": 159.17959594726562,
                                 "Height": 238.40322875976562,
                                 "Left": 277.920654296875,
                                 "Top": 133.08837890625
                             }
                         }
                     ]
                 }
```

具体参数含义可参考aws官方文档

3、可用于KYC





