# JSModel
json string, data &lt;==> model; http json api ==> model &lt;==> local db


# usage

* Cocoapod

```
  pod 'JSModel', '~>0.1.0'
```

* Source

```
  JSModel.m
  JSModel.h
```


* Demo

```
import UIKit

class Home: JSModel {
    var address: String?
    var rooms_count: NSNumber?
    //var owner: User?
    var rooms_name: [String]?
}
```



```
    NSString *json_h = [NSString stringWithFormat:
    @"{\
        \"address\": \"beijing chaoyang sanlitun\",\
        \"rooms_count\": 3,\
        \"owner\": %@,\
        \"rooms_name\": [\
                       \"room_01\",\
                       \"room_02\",\
                       \"room_03\"\
                       ]\
    }", json];
    
    
    Home *home = [Home modelFromJSONString:json_h];
```


# LICENSE

MIT
