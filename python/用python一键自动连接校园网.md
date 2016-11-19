# 用Python一键自动连接校园网

### Python实现

最近想练练python, 这里做了一个自动连接校园网的尝试, 然后连接上了alfred 现在可以实现秒连校园网不用在登陆网站进行输入密码等操作了

![](https://ooo.0o0.ooo/2016/04/10/570a7bc688172.png)

代码如下

```
import requests
payload ={'action':'login','is_pad':'0','force':'0','username':username,'password':password,
'ac_id':'3','type':'1','wbaredirect':'http://net.zju.edu.cn',
'page_succeed':'http://172.30.16.53/help.html',
'user_ip':'10.136.41.64',
'page_logout':'http://www.whut.edu.cn','is_ldap':'0','local_auth':'1',
'mac':'80:e6:50:10:05:c6','page_error':'http://172.30.16.53/help.html',
'save_me':'1','x':'48','y':'6','pop':'1','ac_type':'h3c', 'page_error':'/ac_detect.php',
'gateway_auth':'0', 'local_auth':'1', 'is_debug':'0', 'is_ldap':'0'}

url = 'http://172.30.16.53/cgi-bin/srun_portal'
res = requests.post(url, data = payload)

if len(res.text)!= 123:
	print 'Connected!!'
else: 
	res = requests.post(url, data = payload)
	print 'Connected!!'
```

这里的`payload`是我用自己chrome的后端抓取的`post`包数据

post 给http://172.30.16.53/cgi-bin/srun_portal 这个登陆网站就可以实现模拟登陆

但是麻烦的是在于每次运行都要在`command line` 输入
`python net.py`

比较耗时间

### 联合Alfred

![](https://ooo.0o0.ooo/2016/04/10/570a7bc75a82e.png)
所以联合起mac 上的alfred实现了一个一键式的

首先在`alfred`上建立一个`workflow`

包括关键词 连接一个`script`

将自己的net.py包含进去

```
/usr/bin/python ./net.py
```

这个script比较简单

然后是command line 控制wifi

google了一下发现了结果
![](https://ooo.0o0.ooo/2016/04/10/570a7bc80bc04.png)
但是在`alfred`上如果输入的commandline 命令的话会先把commandline打开然后在键入命令, 很慢而且很麻烦 还要手动关闭

所以又搜索了一下, 发现可以用python内置lib`subprocess`包解决

其中subprocess 里面的操作一般可以使用的有check_output()

eg:

output = check_output('networksetup -setairportpower en0 on', shell = True)

这里的shell = True不能掉
最后的代码如下

```
import requests
from subprocess import check_output

output = check_output('networksetup -setairportpower en0 on', shell = True)
output = check_output('networksetup -setairportnetwork en0 WHUT-WLAN-DORM', shell = True)

payload ={'action':'login','is_pad':'0','force':'0','username':username,'password':password,
'ac_id':'3','type':'1','wbaredirect':'http://net.zju.edu.cn',
'page_succeed':'http://172.30.16.53/help.html',
'user_ip':'10.136.41.64',
'page_logout':'http://www.whut.edu.cn','is_ldap':'0','local_auth':'1',
'mac':'80:e6:50:10:05:c6','page_error':'http://172.30.16.53/help.html',
'save_me':'1','x':'48','y':'6','pop':'1','ac_type':'h3c', 'page_error':'/ac_detect.php',
'gateway_auth':'0', 'local_auth':'1', 'is_debug':'0', 'is_ldap':'0'}

url = 'http://172.30.16.53/cgi-bin/srun_portal'
res = requests.post(url, data = payload)

if len(res.text)!= 123:
	print 'Connected!!'
else: 
	res = requests.post(url, data = payload)
	print 'Connected!!'
```


这里的id等包数据是我个人的, 不适用于大家

所以`payload`包还需要大家自己抓取


###最后
本来准备写个2048的, 不过发现要用`wxpython`好麻烦= = 不然不做GUI的话又没什么意思

接下来还是先复习下scrapy 之前学的都快忘得差不多了

那本`WSP`还没怎么看

目前准备把`Requests`的`tutorial`看完

另外那个net的图标是我用开源包 halfstone QR 做的 可以用一个图像和一个二维码来生成那个图像的二维码 挺好玩的

* 先google二维码在线扫描, 把QR code 转换成URL
* 用开源包和图片转换

这个开源包有人已经做成了[网站](http://spacekid.me/halftone-qr-code-generator/)
![](https://ooo.0o0.ooo/2016/04/10/570a7bc77a35f.png)
原始[论文](http://cgv.cs.nthu.edu.tw/Projects/Recreational_Graphics/Halftone_QRCodes/)在这里
我的`二维码`

![](https://ooo.0o0.ooo/2016/04/10/570a7b76c306f.png)