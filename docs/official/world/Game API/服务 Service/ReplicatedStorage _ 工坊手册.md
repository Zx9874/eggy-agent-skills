# ReplicatedStorage

## 概览

| 字段 | 值 |
| --- | --- |
| Kind | `Service` · 服务 Service |
| Realm | `common` |

### 继承关系

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)（4 属性 / 25 函数 / 6 事件）
  + **[ReplicatedStorage]**

> Service 继承 Unit 仅表示运行时类型关系；作者可用 API 以当前 Service 页面显式列出的成员为准，不自动包含 Unit 的创建、层级或销毁能力。

[ReplicatedStorage](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ReplicatedStorage.html) 是服务端与客户端共享的复制容器，其子单位会自动同步到客户端，但不会创建物理刚体或渲染模型。

## 适用场景

需要让两端访问同一份 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html)、配置对象或共享模块时，将对象放在 [ReplicatedStorage](https://u5-creator.s3.game.163.com/manual/se/game_api/service/ReplicatedStorage.html) 下统一组织。

## 使用要点

通过 game:GetService("ReplicatedStorage") 获取容器，再使用公开的 [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html) 层级查询能力访问已同步的子单位。

## 注意事项

自动复制用于分发容器中的对象，不等于远程调用或权威状态同步；客户端向服务端发请求仍应使用 [RemoteEvent](https://u5-creator.s3.game.163.com/manual/se/game_api/data/RemoteEvent.html) 等公开通信接口，并由服务端校验输入。

## 关联类型

* [Unit](https://u5-creator.s3.game.163.com/manual/se/game_api/unit/Unit.html)
