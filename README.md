# iOS-Firmware-Keys-Parser
Simple bash script to get iOS Firmware Keys (when available) from theapplewiki.com .

## Installation
Clone this repo with:

```shell
git clone https://github.com/iam-theKid/iOS-Firmware-Keys-Parser.git
```
## Usage

Execute

```shell
iOS-Firmware-Keys-Parser/getFwKeys.sh
```
Follow the prompts and provide:
- iOS version (ex. 15.6) or a BuildId (ex. 19G71)
- Device Identifier (ex. iPad7,6, iPhone 9,1)

Script will give the option to save the full Firmware Keys Json file and print the iBEC and iBSS iv and key.

![image](https://github.com/iam-theKid/iOS-Firmware-Keys-Parser/assets/72942240/c4c7d93b-042a-4a0d-b9ba-246b5b2b5e1f)
