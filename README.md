# Handling හෙළPay Links

## Setup

To properly handle හෙළPay Links in your iOS WebView project, you will need this helper class.

- `helapay-links/HelaPayLinkHandler.swift`

First, clone this repo.

- `https://github.com/PayHereDevs/helapay-link-handler.git`

Next, copy it into your Xcode project. Follow __one__ of the following steps, depending on whether you use `UIWebView` or `WKWebView`.

### For `UIWebView`

##### 1. Set the web view delegate

```swift
class ViewController: UIViewController{
    override func viewWillAppear(_ animated: Bool) {
        // ...

        webView.delegate = self
    }
}
```

##### 2. Implement the `shouldStartLoadWith` method

```swift
extension ViewController: UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {

        // Important check for external suffix
        if let url = request.url, url.absoluteString.hasSuffix("#HKexternal") {
            HelaPayLinkHandler().handleHelaPayLink(url)
            return false
        }
        else{
            return true;
        }

    }
}
```

### For `WKWebView`

##### 1. Set the web view navigation delegate

```swift
class ViewController: UIViewController{
    override func viewWillAppear(_ animated: Bool) {
        // ...

        webView.navigationDelegate = self
    }
}
```

##### 2. Implement the `decidePolicyFor` method

```swift
extension ViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // Important check for external suffix
        if let url = navigationAction.request.url, url.absoluteString.hasSuffix("#HKexternal") {
            HelaPayLinkHandler().handleHelaPayLink(url)
            decisionHandler(.cancel)
        }
        else{
            decisionHandler(.allow)
        }
    }
}
```

