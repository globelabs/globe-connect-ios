# Globe Connect iOS SDK

## Introduction
Globe Connect iOS SDK provides an implementation of Globe APIs e.g Authentication, Amax,
Sms etc. that is easy to use and can be integrated in your existing iOS application. Below shows
some samples on how to use the SDK depending on the functionality that you need to integrate in your
application.

## Basic Usage

###### Figure 1. Authentication

```swift
import GlobeConnect

let url = globeConnect.getAccessUrl()
print(url)

let globeConnect = GlobeConnect(
    appId: "[APP ID]",
    appSecret: "[APP SECRET]"
)

globeConnect.getAccessToken(
    code: "[CODE]",
    success: { json in
        dump(json)
    }, failure: { error in
        print(error)
    })
```

###### Figure 2. Amax

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
import GlobeConnect

let globeConnect = GlobeConnect(
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
