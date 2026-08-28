# Lua设置自定义图片

## 添加引用

要在Lua中设置自定义图片，首先需要保证图片被添加了“引用”，进入编辑界面，在左侧创生面板中右键想要设置的自定义图片，获取Lua引用

![](https://u5-creator.s3.game.163.com/manual/assets/luapic1.DRlSE38K.png)

获取后，你会获得一串整数ID，类似：1809506880，这就是该自定义图片的引用ID，在lua中设置图片时需要使用该ID。

## 设置图片

假如我们想要设置某个图片控件为这张图片，可参考以下操作：

【目标】运行时将这个正方形图片控件修改为上述的自定义图片

![](https://u5-creator.s3.game.163.com/manual/assets/luapic2.Fub6sKJL.png)

1.获取该控件的实体ID，我们这里取到的是“1016506381”

右键获取ID

![](https://u5-creator.s3.game.163.com/manual/assets/luapic3.Bo2cNg9Q.png)

2.初始化中写一段设置图片控件的脚本

```lua
LuaAPI.global_register_trigger_event({EVENT.GAME_INIT},function()
    local player = GameAPI.get_role(1)
    player.set_image_texture_by_key_with_auto_resize('1809506880',1016506381,false)
end)
```

运行即可查看效果。
