
## Globe Connect for Android

### Setting Up

Please refer to this [link](https://github.com/globelabs/globe-connect-android/blob/master/instructions/manual-installation.md) for manual installation of the Globe Connect Android SDK.
        <br />Please refer to this [link](https://github.com/globelabs/globe-connect-android/blob/master/instructions/installation-via-maven.md) to install the Globe Connect Android SDK via Maven Central.

### Authentication

#### Overview

If you haven't signed up yet, please follow the instructions found in [Getting Started](http://www.globelabs.com.ph/docs/#getting-started-create-an-app) to obtain an `App ID` and `App Secret` these tokens will be used to validate most of your interaction requests with the Globe APIs.

    The authenication process follows the protocols of **OAuth 2.0**. The example code below shows how you can swap your app tokens for an access token.

#### Sample Code

```java
Please go to `https://github.com/globelabs/globe-connect-android/blob/master/instructions/authentication-activity.md`
for more detailed explanation on how to do the android sdk authentication flow process.
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Sms sms = new Sms("[short_code]", "[access_token]");

try {
    sms
        .setClientCorrelator("[client_correlator]")
        .setReceiverAddress("[receiver_address]")
        .setMessage("[message]")
        .sendMessage(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch(JSONException e) {
                    e.printStackTrace();
                }
            }
        });

} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

BinarySms sms = new BinarySms("[short_code]", "[access_token]");

try {
    sms
        .setUserDataHeader("[data_header]")
        .setDataCodingScheme([coding_scheme])
        .setReceiverAddress("[receiver_address]")
        .setBinaryMessage("[message]")
        .sendBinaryMessage(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch(JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Ussd ussd = new Ussd("[access_token]");

try {
    ussd
        .setSenderAddress("[short_code]")
        .setUssdMessage("[message]")
        .setAddress("[subscriber_number]")
        .setFlash([flash])
        .sendUssdRequest(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Ussd ussd = new Ussd("[access_token]");

try {
    ussd
        .setSessionId("[session_id]")
        .setAddress("[subscriber_number]")
        .setSenderAddress("[short_code]")
        .setUssdMessage("[message]")
        .setFlash([flash])
        .replyUssdRequest(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Payment payment = new Payment("[access_token]");

try {
    payment
        .setAmount([amount])
        .setDescription("[description]")
        .setEndUserId("[subscriber_number]")
        .setReferenceCode("[reference]")
        .setTransactionOperationStatus("[status]")
        .sendPaymentRequest(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Payment payment = new Payment("[access_token]");

try {
    payment
        .setAppId("[app_id]")
        .setAppSecret("[app_secret]")
        .getLastReferenceCode(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Amax amax = new Amax([app_id], [app_secret]);

try {
    amax
        .setRewardsToken("[rewards_token]")
        .setAddress("[subscriber_number]")
        .setPromo("[promo]")
        .sendRewardRequest(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Location location = new Location("[access_token]");

try {
    location
        .setAddress("[subscriber_number]")
        .setRequestedAccuracy([accuracy])
        .getLocation(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
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

TODO

#### Subscriber Balance

The following example shows how you can get the subscriber balance.

##### Sample Code

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Subscriber subscriber = new Subscriber("[access_token]");

try {
    subscriber
        .setAddress("[subscriber_number]")
        .getSubscriberBalance(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
```

##### Sample Results

```json
{
    terminalLocationList:
    {
        terminalLocation:
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

```java
import ph.com.globe.connect.*;
import org.json.JSONObject;
import org.json.JSONException;

Subscriber subscriber = new Subscriber("[access_token]");

try {
    subscriber
        .setAddress("[subscriber_number]")
        .getSubscriberReloadAmount(new AsyncHandler() {
            @Override
            public void response(HttpResponse response) throws HttpResponseException {
                try {
                    JSONObject json = new JSONObject(response.getJsonResponse().toString());

                    System.out.println(json.toString());
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });
} catch(ApiException | HttpRequestException | HttpResponseException e) {
    e.printStackTrace();
}
```

##### Sample Results

```json
{
    terminalLocationList:
    {
        terminalLocation:
        [
            {
                address: "639171234567",
                reloadAmount: "30000"
            }
        ]
    }
}
```


## Globe Connect for iOS 10

### Setting Up

Please refer to this [link](https://github.com/globelabs/globe-connect-ios/blob/feature/documentation-installation/installation/manual.md) for manual installation of Globe Connect iOS SDK.
        <br/>Please refer to this [link](https://github.com/globelabs/globe-connect-ios/blob/feature/documentation-installation/installation/cocoapods.md) for Globe Connect iOS SDK installtion via CocoaPods.

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

TODO

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
    terminalLocationList:
    {
        terminalLocation:
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
    terminalLocationList:
    {
        terminalLocation:
        [
            {
                address: "639171234567",
                reloadAmount: "30000"
            }
        ]
    }
}
```
