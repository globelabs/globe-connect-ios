# Globe Connect iOS SDK

## Introduction
Globe Connect iOS SDK provides an implementation of Globe APIs e.g Authentication, Amax,
Sms etc. that is easy to use and can be integrated in your existing iOS application. Below shows
some samples on how to use the SDK depending on the functionality that you need to integrate in your
application.

## Installation
There are 2 ways to install the SDK either via the SDK Builder or via Cocoapods. Check out the links
for the installation instructions:
- [Manual (via SDK Builder)](https://github.com/globelabs/globe-connect-ios/blob/master/installation/manual.md)
- [Cocoapods](https://github.com/globelabs/globe-connect-ios/blob/master/installation/cocoapods.md)

## Basic Usage

###### Figure 1. Authentication

### Authenticate

You need to setup a URL scheme in order for this work. Check this [link](https://github.com/globelabs/globe-connect-ios/blob/master/installation/url-schemes.md)
on how to setup a URL scheme in your XCode project.

```swift
//
//  sample implementation of login using the ViewController.swift file
//

import UIKit
import GlobeConnectIOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginViaGlobe(_ sender: Any) {
        let authenticate = Authenticate()

        authenticate.login(
            viewController: self,
            appId: "[APP ID]",
            appSecret: "[APP SECRET]",
            success: { results in
                // access token will returned here
                print(results)
            },
            failure: { error in
                print(error)
            }
        )
    }
}

//
// Add the following code at the bottom of your AppDelegate.swift file.
// Make sure that a URL scheme is set for this to work.
//

func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    if let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] {

        if (String(describing: sourceApplication) == "com.apple.SafariViewService") {
            let authenticate = Authenticate()
            authenticate.listenForRequest(url: url)
            return true
        }
    }

    return true
}
```

###### Figure 2. Amax

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    appId: "[APP ID]",
    appSecret: "[APP SECRET]"
)

globeConnect.sendRewardRequest(
    address: "[ADDRESS]",
    promo: "[PROMO NAME]",
    rewardsToken: "REWARDS TOKEN",
    success : { json in
        dump(json)
    },
    failure: { error in
        print(error)
    }
)
```

###### Figure 3. Binary SMS

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    shortCode: "[SHORT CODE]",
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.sendBinaryMessage(
    address: "[ADDRESS]",
    message: "[BINARY MESSAGE]",
    header: "[USER DATA HEADER]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    }
)
```

###### Figure 4. Location

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.getLocation(
    address: "092XXXXXXXX",
    success : { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 5. Payment (Send Payment Request)

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    appId: "[APP ID]",
    appSecret: "[APP SECRET]",
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.sendPaymentRequest(
    amount: [AMOUNT],
    description: "[DESCRIPTION]",
    endUserId: "[END USER ID]",
    referenceCode: "[REFERENCE CODE]",
    transactionOperationStatus: "[STATUS]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 6. Payment (Get Last Reference ID)

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    appId: "[APP ID]",
    appSecret: "[APP SECRET]",
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.getLastReferenceCode(
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 7. Sms

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    shortCode: "[SHORT CODE]",
    accessToken: "[ACCESS TOKEN]"
)

connect.sendMessage(
    address: "[ADDRESS]",
    message: "[MESSAGE]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    }
)
```

###### Figure 8. Subscriber (Get Balance)

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.getSubscriberBalance(
    address: "[ADDRESS]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 9. Subscriber (Get Reload Amount)

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.getSubscriberReloadAmount(
    address: "[ADDRESS]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 10. USSD (Send)

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    shortCode: "[SHORT CODE]",
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.sendUssdRequest(
    address: "[ADDRESS]",
    message: "[MESSAGE]",
    flash: [FLASH],
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 11. USSD (Reply)

```swift
import GlobeConnectIOS

let globeConnect = GlobeConnectIOS(
    shortCode: "[SHORT CODE]",
    accessToken: "[ACCESS TOKEN]"
)

globeConnect.replyUssdRequest(
    address: "[ADDRESS]",
    message: "[MESSAGE]",
    sessionId: "[SESSION ID]",
    flash: [FLASH],
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```
