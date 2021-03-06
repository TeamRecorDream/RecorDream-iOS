# RecorDream ๐ฟ<img src="./Asset/๋ก๊ณ .png" align=left width=100>
> ๊ธฐ์ ์งํ์ ๊ฟ ๊ธฐ๋ก๊ณผ ๊ด๋ฆฌ๋ฅผ ๋๋ Dream Archiving Service <br>
<br />

> 30th THE SOPT AppJam <br/>
> ํ๋ก์ ํธ ๊ธฐ๊ฐ: 22.07.09 ~ 22.07.23

<br>

## About

<img src="https://user-images.githubusercontent.com/70689381/180933545-05ce0c70-2cde-42fb-b508-a5f663a821c3.jpeg" width=1000>


<br />


## ๐ RecorDream iOS Developers

<img src="https://user-images.githubusercontent.com/70689381/179389399-b546c0dd-e65f-4ade-9f35-9b2dda6a72fd.JPG" width = 650>

| `Create` | `Share` | `Play` |
|:--:|:--:|:--:|
|<img src="./Asset/์์ง.png" width=200>|<img src="./Asset/์ํฌ.jpeg" width=200>|<img src="./Asset/์คํ.jpeg" width=200>|
|**์์ง**|**์ํฌ**|**์คํ**|
|[@513sojin](https://github.com/513sojin)|[@EunHee-Jeong](https://github.com/EunHee-Jeong)|[@88yhtserof](https://github.com/88yhtserof)|
|`Record View` <br> `Home View` <br> `Reusable Component`|`Custom Tabbar` <br> `Storage View` <br> `Search View`|`Remote Notification` <br> `Detail View` <br> `Mypage View`|
| `Custom UI` | `Project Setting` | `FCM Setting` |


<br />

## ๐  Development Environment

## ๐ Package Dependency

| Name | Tag | Management Tool |
| --- | --- | --- |
| HeeKit | Global Extension | SPM |
| IQKeyboardManager | Layout, Keyboard | - |
| SnapKit | Layout | - |
| Then | Sugar API | - |


<br />

## โ๏ธ Convention

`Coding Convention` ยท `Git Flow`

<details markdown="1">
<summary>Coding Convention</summary>

<br>
๐ Team Wiki ๋ณด๋ฌ๊ฐ๊ธฐ https://github.com/TeamRecorDream/RecorDream-iOS/wiki/%08Coding-Convention

</details>

<details markdown="2">
<summary>Git Flow</summary>

<br>

```
1. Issue๋ฅผ ์์ฑํ๋ค. // ์์์ ๋จ์, ๋ฒํธ ๋ถ์ฌ

2. Issue์ Feature Branch๋ฅผ ์์ฑํ๋ค. // ex - feature/#์ด์๋ฒํธ

3. ~์์~ // Add - Commit - Push - Pull Request ์ ๊ณผ์ 

4. Pull Request๊ฐ ์์ฑ๋๋ฉด ์์ฑ์ ์ด์ธ์ ๋ค๋ฅธ ํ์์ด Code Review๋ฅผ ํ๋ค.

5. Code Review๊ฐ ์๋ฃ๋๊ณ , 2๋ช์ด Approve ํ๋ฉด Pull Request ์์ฑ์๊ฐ develop Branch๋ก merge ํ๋ค. // Conflicts ๋ฐฉ์ง

6. ๋ค๋ฅธ ํ์๋ค์ merge๋ ์์๋ฌผ์ pullํ๊ณ  ๋ค์ ๊ฐ์ ๋งก์ ์์์ ์ด์ด๋๊ฐ๋ค.
```
</details>

<br />

## ๐ Project Architecture

```swift

RecorDream-iOS
 โโโ Info.plist
 โโโ Resource
 โ   โโโ Assets
 โ   โ      โโโ AppIcon.xcassets
 โ   โโโ Colors
 โ   โ      โโโ Colors.xcassets
 โ   โโโ Images
 โ   โโโ Fonts
 โโโ Source
 โ   โโโ Application
 โ   โ   โโโ AppDelegate
 โ   โ   โโโ SceneDelegate
 โ   โโโ Common
 โ   โ   โโโ Constants
 โ   โ          โโโ ColorFactory
 โ   โ          โโโ FontFactory
 โ   โ          โโโ ImageFactory
 โ   โ   โโโ Protocols
 โ   โโโ Presentation
 โ   โ   โโโ Create
 โ   โ        โโโ Models
 โ   โ        โโโ ViewControllers
 โ   โ   โโโ Play
 โ   โ        โโโ Models
 โ   โ        โโโ ViewControllers
 โ   โ   โโโ Share
 โ   โ        โโโ Models
 โ   โ        โโโ ViewControllers
 โ   โโโ Service
 โ       โโโ DTO
 โ            โโโ Network
 โ              โโโ EndPoint
 โ              โโโ Manager
 โ       โโโ Mock 
 โโโ RecorDreamTests
 
HeeKit
 โโโ Sources
 โ     โโโ HeeKit
 โ           โโโ Protocol
 โ           โโโ Extensions
 โโโ Tests
 โ     โ
 โโโ   โโโ HeeKitTests
```
