#coding=utf-8
import requests,re,urllib
url_list = ['http://www.budejie.com/pic/']
# for index in range(2,6):
#     url_list.append('http://www.budejie.com/pic/%d'%index)

for  url in url_list:
    req = requests.get(url)
    pic = req.content
    pic_reg = r'data-original="(.*?)"'
    # title_reg = r'title="(.*?)"'
    for  info in pic:
        picture = re.findall(pic_reg,pic)
        for i  in  range(len(picture)):
            name = picture[i].split('/')[-1].split('.')[0]
            houzhu = picture[i].split('/')[-1].split('.')[-1]
            if name:
                urllib.urlretrieve(picture[i],'pic/%s.%s'%(name,houzhu))
            else:
                break
            print name+'.'+houzhu



