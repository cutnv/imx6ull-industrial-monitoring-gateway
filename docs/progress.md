# 项目进度记录

用于记录每个阶段做了什么、为什么这样做、验证结果和遗留问题。

## 2026-09-22：基础验证与 U-Boot 准备

### 已完成

- 恢复并验证官方 SD 卡系统。
- 确认 7 英寸 1024 × 600 LCD 正常显示。
- 确认 GT911 触摸设备能产生 Linux input event。
- 完成 Ethernet 双向 ping 测试。
- 完成 CAN 回环测试。
- 准备 Ubuntu 交叉编译环境。
- 编译 U-Boot v2024.10。
- 加入 ALIENTEK i.MX6ULL ALPHA V2.4 独立板级 target。
- 使用板卡 DDR 校准参数重新编译并从 SD 启动新 U-Boot。
- 验证 SD、eMMC 识别以及手动加载 zImage 和 Linux DTB。

### 当前结论

U-Boot 板级移植、SD 启动和双网口已完成基础验证。项目准备进入 Linux 与外设功能开发阶段。

### 下一阶段

- 校对 eMMC 8-bit 配置并验证读写、启动。
- 整理 U-Boot DTS 和默认环境。
- 完成多次冷启动与恢复测试。
- 再进入 Linux、CAN 数据服务、触控 HMI 和远程通信开发。

## 后续记录格式

每次完成一个可验证的小阶段，追加以下内容：

```text
日期：
目标：
修改内容：
关键命令：
验证方法：
验证结果：
遇到的问题：
原因：
解决办法：
下一步：
```
## 2026-09-22：U-Boot 双网口与启动链验证

- 修正共享 MDIO 基地址为 `0x020b4000`。
- 添加两个 LAN8720A PHY、复位 GPIO 和共享 MDIO 配置。
- 同时初始化 FEC1、FEC2 的 50 MHz RMII 时钟。
- 启用 MII、MDIO、SMSC PHY 和双网口驱动选项。
- U-Boot 两个网口均可 Ping 通电脑。
- U-Boot 环境可从 SD 卡持久恢复。
- 成功加载 `zImage` 和设备树并启动 Linux 4.1.15。
- 根文件系统 `/dev/mmcblk0p2` 正常读写。
- Linux `eth0`、`eth1` 均通过 Ping 测试，零丢包。
- 验证镜像 SHA256：`bcbfd85d1eb3477511c89a3a44b673002a16b60b947d8cc899d874a401226a17`。

下一步：验证 eMMC 启动、统一 MAC 地址策略，然后进入 CAN 和工业监测功能开发。
