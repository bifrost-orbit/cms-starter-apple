# CMS Orbit starter for Apple platforms

A SwiftUI app for iPhone, iPad and Mac that reads its pages from [CMS Orbit](https://bifrostorbit.com/products/cms-orbit/), the headless CMS in Bifröst Orbit, with the Swift SDK `CMSOrbit`. It is the finished project from the [Apple platforms quickstart](https://docs.bifrostorbit.com/cms/developers/quickstart-apple/): pages open by their address, your own SwiftUI views for the blocks editors place, links to your website open inside the app, and pages refresh on pull and when the app comes back.

## Set up

1. **Create your copy.** Select **Use this template** on GitHub, or run `gh repo create my-app --template bifrost-orbit/cms-starter-apple --private --clone`.
2. **Add your settings.** In `Northwilds/CMSSettings.swift`, fill in the API address, your public `cms_pk_` key and region from **Configuration › API keys** and **Configuration › Environments** in CMS Orbit, and your website's domain. The public key only reads what is published, so it is safe in the app. Never put a secret key in the app.
3. **Run it.** Open `Northwilds.xcodeproj` in Xcode, change the bundle identifier under **Signing & Capabilities** to one of your own, choose a simulator or **My Mac**, and run.

## What's inside

| File | What it does |
| --- | --- |
| `Northwilds/CMSSettings.swift`, `Northwilds/CMS.swift` | The settings and the CMS Orbit client |
| `Northwilds/ContentView.swift`, `Northwilds/PageScreen.swift` | Navigation, the menu, and one screen for every page: redirects and not found |
| `Northwilds/Components/` | The views: `hero`, `featureSpotlight` and `action`, and the map that picks one for each block |
| `Northwilds/PageCache.swift` | Keeps pages for a few minutes, and reads them again on pull and when the app returns |
| `Northwilds/DraftScreen.swift` | Shows a draft fetched through your own server |
| `project.yml` | The project for [XcodeGen](https://github.com/yonaskolb/XcodeGen), if you prefer to generate `Northwilds.xcodeproj` with `xcodegen generate` |

## Make it yours

- Write your views in `Northwilds/Components/` and add them to `ComponentMap.swift`, using the component keys from your own space. **Configuration › Components** lists them.
- Drafts need a server of yours that holds the secret key and checks the preview token: set its address in `draftServerURL`. The [quickstart](https://docs.bifrostorbit.com/cms/developers/quickstart-apple/) shows the server side, and how to refresh the app from a webhook with a silent push.

Needs Xcode 16 or later, iOS 17 or macOS 14, and `CMSOrbit` 0.2.

## Licence

MIT. See [LICENSE](LICENSE).
