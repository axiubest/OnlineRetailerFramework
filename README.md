# OnlineRetailerFramework
电子商务框架

## 简单封装电商类常用控件，首页瀑布流信息展示，详情页，加载更多页，购物车，个人中心，登录等，持续集成更新中， 内有catogry分类等，封装多年积累代码，有空持续更新中，仅供学习交流使用，请勿用于任何商业用途

# type：近期在做WKWebView，借鉴维基百科，优化加载速度，会发布到此版本中。

### 1 Net-request

* 网络请求采用双层封装意在最少减轻controller中代码量
* XIU_NetAPIClient对AFNetwork进行封装暴露出request接口，供XIU_NetAPIManager接口类调用，该类为单粒全局仅此一个。所有网络接口共同调用。
* XIU_NetAPIClient中对网络请求进行了缓存处理，缓存位置在本地plist文件中。

```Objective-C
//XIU_NetAPIClient

+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;


```

```Objective-C
//XIU_NetAPIManager接口根类
+ (instancetype)sharedManager；

#pragma mark----login
- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id data, NSError *error))block;

```

#### 1
![image](https://github.com/axiubest/OnlineRetailerFramework/blob/master/OnlineRetailerFrameWork/AXIU.gif)


