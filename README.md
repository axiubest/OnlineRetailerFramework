# OnlineRetailerFramework
电子商务框架

## 简单封装电商类常用控件，首页瀑布流信息展示，详情页，加载更多页，购物车，个人中心，登录等，持续集成更新中， 内有catogry分类等，封装多年积累代码，有空持续更新中，仅供学习交流使用，请勿用于任何商业用途



### 1 Net-request

网络请求采用双层封装意在最少减轻controller中代码量
XIU_NetAPIClient对AFNetwork进行封装暴露出request接口，供XIU_NetAPIManager接口类调用，该类为单粒全局仅此一个。所有网络接口共同调用。

```Objective-C
+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;


```

#### 1
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%883.56.59.png)

#### 2
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%883.57.10.png)

#### 3
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%883.57.18.png)

#### 4
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%883.57.28.png)

#### 5
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%883.57.37.png)

#### 6
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%883.57.45.png)

#### 7
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.00.21.png)

#### 8
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.00.34.png)

#### 9
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.01.05.png)

#### 10
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.01.25.png)

#### 11
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.01.32.png)

#### 12
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.01.44.png)

#### 13
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.01.53.png)

#### 14
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.02.04.png)

#### 15
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.02.12.png)

#### 16
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.02.19.png)

#### 17
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/showImg/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202017-07-18%20%E4%B8%8B%E5%8D%884.02.37.png)

