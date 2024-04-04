
# UsernameGenerator

这是一个用于生成用户名的Python脚本。主要目的是为了测试短用户名，但它也有许多其他用途，比如密码生成、测试数据生成等。


## 安装

首先，你需要安装Python。你可以在[Python官网](https://www.python.org/)下载并安装。

## 使用方法

### 方法一：直接运行main.py

你可以使用以下命令直接运行main.py：

```bash
curl https://raw.githubusercontent.com/6art/UsernameGenerator/main/main.py | python
```

### 方法二：克隆仓库并运行

你可以使用以下命令来克隆仓库并运行脚本：

```bash
git clone https://github.com/6art/UsernameGenerator.git && python UsernameGenerator/main.py
```

### 方法三
```bash
curl -sS -O [https://github.com/6art/UsernameGenerator/raw/main/username_generator.sh](https://github.com/6art/UsernameGenerator/raw/main/username_generator.sh) && chmod +x username_generator.sh && ./username_generator.sh
```

运行上述命令后，按照提示操作即可。

## 功能

- 生成特定位数或位数范围的字典
- 字符构成可选为：
    - 所有字符为[a-z]+[0-9]
    - 所有字符为[a-z]+[A-Z]+[0-9]
    - 首字符不包含数字，除此之外，所有字符为[a-z]+[0-9]
    - 自定义模式，每一位字符的构成可以自定义

## 贡献

欢迎任何形式的贡献，包括但不限于问题反馈、功能建议和代码提交。

## 许可证

MIT
```
