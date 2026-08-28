# ReplicatedFirst

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[ReplicatedFirst]**

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[ReplicatedFirst](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ReplicatedFirst.html) 是优先复制服务容器，其子单位会在客户端加入时优先复制，适合放置加载初期需要访问的关键资源。

## 适用场景

客户端启动早期需要读取加载界面脚本或初始化配置时，从 [ReplicatedFirst](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ReplicatedFirst.html) 容器访问预先放置的子单位。

## 使用要点

通过 game:GetService("ReplicatedFirst") 获取容器，再使用公开的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 层级查询能力读取已复制的子单位。

## 注意事项

当前公开契约只声明子单位优先复制语义，未声明加载完成事件或阻断式加载控制；不要自行类比外部引擎的额外 API。

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
