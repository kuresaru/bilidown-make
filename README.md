# bilidown-make

用 GNU Make 的方式下载Bilibili视频

(只考虑了简单情况 不支持多p下载 只能下载可以得到的最高画质)


## Usage:

```shell
# 下载 BV1vy4y1J7rA
make BV1vy4y1J7rA.mp4

# 下载 av83005929
make av83005929.mp4
```

## Login:

```
编辑config.mk 设置AUTH变量为有效的SESSDATA
部分视频或画质需要登录特定帐号才能下载
```


## Dependencies:

+ [GNU Make](http://www.gnu.org/software/make/)
+ [GNU Bash](http://www.gnu.org/software/bash/)
+ [FFmpeg](http://www.ffmpeg.org/)
+ [CURL](https://curl.se/)


## References:

+ [Bilibili API](https://github.com/SocialSisterYi/bilibili-API-collect)
+ [JSON.sh](https://github.com/dominictarr/JSON.sh)


## Author:


[暮光小猿wzt](http://www.scraft.top)