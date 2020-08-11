## WCYImageWaveProgressView

[![Anurag's github stats](https://github-readme-stats.vercel.app/api?username=WeiCY)](https://github.com/anuraghazra/github-readme-stats)

在网上有很多常见的进度展示，各种波浪，但是大部分都是圆形、方形、水滴形等。前几天我遇到一个需求就是需要根据公司logo自定义图形。
为了实现可以自定义图片的波浪进度，写了这个小工具。这个工具可以根据不同的图片设置进度，波浪的显示起伏、速度这些也都也可设置，只需要传入两个图片（进度0和进度100%的两张图片）就可以实现这个功能。


v 1.0.0

简单的实现功能，但是生成方法，修改属性未提取出来，修改只能在类中修改，不适合一个项目中多个不同形状的进度。

v 1.0.1

新增demo
进一步完善，一句话生成波浪效果。图片提取出来，可以在方法中设置图片。
使用更简单，一个项目中可以使用多种图片的进度。
