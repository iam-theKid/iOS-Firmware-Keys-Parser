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

![image](https://github.com/iam-theKid/iOS-Firmware-Keys-Parser/assets/72942240/4535a805-0aa1-4d42-bb43-176ae3827072)
