
## Globe Connect for iOS 10

### Setting Up

Please refer to this <a target="_blank" href="https://github.com/globelabs/globe-connect-ios/blob/feature/documentation-installation/installation/manual.md">link</a> for manual installation of Globe Connect iOS SDK.
        <br/>Please refer to this <a target="_blank" href="https://github.com/globelabs/globe-connect-ios/blob/feature/documentation-installation/installation/cocoapods.md">link</a> for Globe Connect iOS SDK installtion via CocoaPods.

### Authentication

#### Overview

If you haven't signed up yet, please follow the instructions found in [Getting Started](http://www.globelabs.com.ph/docs/#getting-started-create-an-app) to obtain an `App ID` and `App Secret` these tokens will be used to validate most of your interaction requests with the Globe APIs.

    The authenication process follows the protocols of **OAuth 2.0**. The example code below shows how you can swap your app tokens for an access token.

#### Sample Code

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
            appId: "[app_id]",
            appSecret: "[app_secret]",
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

#### Sample Results

```json
{
    "access_token":"1ixLbltjWkzwqLMXT-8UF-UQeKRma0hOOWFA6o91oXw",
    "subscriber_number":"9171234567"
}
```

### SMS

#### Overview

Short Message Service (SMS) enables your application or service to send and receive secure, targeted text messages and alerts to your Globe / TM subscribers.

        Note: All API calls must include the access_token as one of the Universal Resource Identifier (URI) parameters.

#### SMS Sending

Send an SMS message to one or more mobile terminals:

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    shortCode: "[short_code]",
    accessToken: "[access_token]"
)

connect.sendMessage(
    address: "[subscriber_number]",
    message: "[message]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    }
)
```

##### Sample Results

```json
{
    "outboundSMSMessageRequest": {
        "address": "tel:+639175595283",
        "deliveryInfoList": {
            "deliveryInfo": [],
            "resourceURL": "https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/8011/requests?access_token=3YM8xurK_IPdhvX4OUWXQljcHTIPgQDdTESLXDIes4g"
        },
        "senderAddress": "8011",
        "outboundSMSTextMessage": {
            "message": "Hello World"
        },
        "receiptRequest": {
            "notifyURL": "http://test-sms1.herokuapp.com/callback",
            "callbackData": null,
            "senderName": null,
            "resourceURL": "https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/8011/requests?access_token=3YM8xurK_IPdhvX4OUWXQljcHTIPgQDdTESLXDIes4g"
        }
    }
}
```

#### SMS Binary

Send binary data through SMS:

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    shortCode: "[short_code]",
    accessToken: "[access_token]"
)

globeConnect.sendBinaryMessage(
    address: "[subscriber_number]",
    message: "[message]",
    header: "[data_header]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    }
)
```

##### Sample Results

```json
{
    "outboundBinaryMessageRequest": {
        "address": "9171234567",
        "deliveryInfoList": {
            "deliveryInfo": [],
            "resourceURL": "https://devapi.globelabs.com.ph/binarymessaging/v1/outbound/{senderAddress}/requests?access_token={access_token}",
        "senderAddress": "21581234",
        "userDataHeader": "06050423F423F4",
        "dataCodingScheme": 1,
        "outboundBinaryMessage": {
            "message": "samplebinarymessage"
        },
        "receiptRequest": {
          "notifyURL": "http://example.com/notify",
          "callbackData": null,
          "senderName": null
        },
        "resourceURL": "https://devapi.globelabs.com.ph/binarymessaging/v1/outbound/{senderAddress}/requests?access_token={access_token}"
    }
}
```

### USSD

#### Overview

USSD are basic features built on most smart phones which allows the phone owner to interact with menu item choices.

#### USSD Sending

The following example shows how to send a USSD request.

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    shortCode: "[short_code]",
    accessToken: "[access_token]"
)

globeConnect.sendUssdRequest(
    address: "[subscriber_number]",
    message: "[message]",
    flash: [flash],
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

##### Sample Results

```json
{
    "outboundUSSDMessageRequest": {
        "address": "639954895489",
        "deliveryInfoList": {
            "deliveryInfo": [],
            "resourceURL": "https://devapi.globelabs.com.ph/ussd/v1/outbound/21589996/reply/requests?access_token=access_token"
        },
        "senderAddress": "21580001",
        "outboundUSSDMessage": {
            "message": "Simple USSD Message\nOption - 1\nOption - 2"
        },
        "receiptRequest": {
            "ussdNotifyURL": "http://example.com/notify",
            "sessionID": "012345678912"
        },
        "resourceURL": "https://devapi.globelabs.com.ph/ussd/v1/outbound/21589996/reply/requests?access_token=access_token"
    }
}
```

#### USSD Replying

The following example shows how to send a USSD reply.

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    shortCode: "[short_code]",
    accessToken: "[access_token]"
)

globeConnect.replyUssdRequest(
    address: "[subscriber_number]",
    message: "[message]",
    sessionId: "[session_id]",
    flash: [flash],
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

##### Sample Results

```json
{
    "outboundUSSDMessageRequest": {
        "address": "639954895489",
        "deliveryInfoList": {
            "deliveryInfo": [],
            "resourceURL": "https://devapi.globelabs.com.ph/ussd/v1/outbound/21589996/reply/requests?access_token=access_token"
        },
        "senderAddress": "21580001",
        "outboundUSSDMessage": {
            "message": "Simple USSD Message\nOption - 1\nOption - 2"
        },
        "receiptRequest": {
            "ussdNotifyURL": "http://example.com/notify",
            "sessionID": "012345678912",
            "referenceID": "f7b61b82054e4b5e"
        },
        "resourceURL": "https://devapi.globelabs.com.ph/ussd/v1/outbound/21589996/reply/requests?access_token=access_token"
    }
}
```

### Payment

#### Overview

Your application can monetize services from customer's phone load by sending a payment request to the customer, in which they can opt to accept.

#### Payment Requests

The following example shows how you can request for a payment from a customer.

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    appId: "[app_id]",
    appSecret: "[app_secret]",
    accessToken: "[access_token]"
)

globeConnect.sendPaymentRequest(
    amount: [amount],
    description: "[description]",
    endUserId: "[subscriber_number]",
    referenceCode: "[reference]",
    transactionOperationStatus: "[status]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

##### Sample Results

```json
{
    "amountTransaction":
    {
        "endUserId": "9171234567",
        "paymentAmount":
        {
            "chargingInformation":
            {
                "amount": "0.00",
                "currency": "PHP",
                "description": "my application"
            },
            "totalAmountCharged": "0.00"
        },
        "referenceCode": "12341000023",
        "serverReferenceCode": "528f5369b390e16a62000006",
        "resourceURL": null
    }
}
```

#### Payment Last Reference

The following example shows how you can get the last reference of payment.

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    appId: "[app_id]",
    appSecret: "[app_secret]",
    accessToken: "[access_token]"
)

globeConnect.getLastReferenceCode(
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

##### Sample Results

```json
{
    "referenceCode": "12341000005",
    "status": "SUCCESS",
    "shortcode": "21581234"
}
```

### Amax

#### Overview

Amax is an automated promo builder you can use with your app to award customers with certain globe perks.

#### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    appId: "[app_id]",
    appSecret: "[app_secret]"
)

globeConnect.sendRewardRequest(
    address: "[subscriber_number]",
    promo: "[promo]",
    rewardsToken: "[rewards_token]",
    success : { json in
        dump(json)
    },
    failure: { error in
        print(error)
    }
)
```

#### Sample Results

```json
{
    "outboundRewardRequest": {
        "transaction_id": 566,
        "status": "Please check your AMAX URL for status",
        "address": "9065272450",
        "promo": "FREE10MB"
    }
}
```

### Location

#### Overview

To determine a general area (lat,lng) of your customers you can utilize this feature.

#### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    accessToken: "[access_token]"
)

globeConnect.getLocation(
    address: "[subscriber_number]",
    success : { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

#### Sample Results

```json
{
    "terminalLocationList": {
        "terminalLocation": {
            "address": "tel:9171234567",
            "currentLocation": {
                "accuracy": 100,
                "latitude": "14.5609722",
                "longitude": "121.0193394",
                "map_url": "http://maps.google.com/maps?z=17&t=m&q=loc:14.5609722+121.0193394",
                "timestamp": "Fri Jun 06 2014 09:25:15 GMT+0000 (UTC)"
            },
            "locationRetrievalStatus": "Retrieved"
        }
    }
}
```

### Subscriber

#### Overview

Subscriber Data Query API interface allows a Web application to query the customer profile of an end user who is the customer of a mobile network operator.

#### Subscriber Balance

The following example shows how you can get the subscriber balance.

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    accessToken: "[access_token]"
)

globeConnect.getSubscriberBalance(
    address: "[subscriber_number]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

##### Sample Results

```json
{
    "terminalLocationList":
    {
        "terminalLocation":
        [
            {
                address: "639171234567",
                subBalance: "60200"
            }
        ]
    }
}
```

#### Subscriber Reload

The following example shows how you can get the subscriber reload amount.

##### Sample Code

```swift
import GlobeConnect

let globeConnect = GlobeConnect(
    accessToken: "[access_token]"
)

globeConnect.getSubscriberReloadAmount(
    address: "[subscriber_number]",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

##### Sample Results

```json
{
    "terminalLocationList":
    {
        "terminalLocation":
        [
            {
                address: "639171234567",
                reloadAmount: "30000"
            }
        ]
    }
}
```
