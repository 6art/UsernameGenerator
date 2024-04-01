import os
import string
import itertools
import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

def get_input(prompt, error_msg, valid_func):
    while True:
        value = input(prompt)
        if valid_func(value):
            return value
        else:
            print(error_msg)

# 检查并安装必要的库
required_packages = ['os', 'string', 'itertools', 'subprocess', 'sys']
for package in required_packages:
    try:
        __import__(package)
    except ImportError:
        install(package)

# 询问保存路径
print("你希望将文件保存在哪里？")
print("1. 当前目录")
print("2. 自定义目录")
choice = get_input("请输入你的选择（1或2）：", "输入无效，请输入1或2", lambda x: x in ['1', '2'])

if choice == '1':
    path = os.getcwd()
elif choice == '2':
    path = get_input("请输入你希望保存的目录：", "输入无效，请输入有效的目录", os.path.isdir)
    if not os.access(path, os.W_OK):
        print("抱歉，这个目录没有写入权限。请重新运行脚本并选择一个有写入权限的目录。")
        exit()

# 询问位数范围
print("你希望生成特定位数的字典还是位数范围的字典？")
print("1. 特定位数")
print("2. 位数范围")
choice = get_input("请输入你的选择（1或2）：", "输入无效，请输入1或2", lambda x: x in ['1', '2'])

if choice == '1':
    start = end = int(get_input("请输入字典的位数：", "输入无效，请输入有效的数字", str.isdigit))
elif choice == '2':
    start = int(get_input("请输入字典的最小位数：", "输入无效，请输入有效的数字", str.isdigit))
    end = int(get_input("请输入字典的最大位数：", "输入无效，请输入有效的数字", str.isdigit))

# 询问字符构成
print("你希望字符由什么构成？")
print("1. 所有字符为[a-z]+[0-9]")
print("2. 所有字符为[a-z]+[A-Z]+[0-9]")
print("3. 首字符不包含数字，除此之外，所有字符为[a-z]+[0-9]")
print("4. 自定义模式")
choice = get_input("请输入你的选择（1，2，3或4）：", "输入无效，请输入1，2，3或4", lambda x: x in ['1', '2', '3', '4'])

if choice == '1':
    chars = string.ascii_lowercase + string.digits
    filename_prefix = "所有字符为[a-z]+[0-9]"
elif choice == '2':
    chars = string.ascii_letters + string.digits
    filename_prefix = "所有字符为[a-z]+[A-Z]+[0-9]"
elif choice == '3':
    chars = string.ascii_lowercase
    filename_prefix = "首字符不包含数字，除此之外，所有字符为[a-z]+[0-9]"
elif choice == '4':
    chars = []
    char_choices = ["所有字符为[a-z]+[0-9]", "所有字符为[0-9]", "所有字符为[a-z]", "所有字符为[a-z]+[A-Z]+[0-9]"]
    for i in range(start):
        print(f"请输入第{i+1}位字符的构成：")
        print("1. 第{i+1}位字符为[a-z]+[0-9]")
        print("2. 第{i+1}位字符为[0-9]")
        print("3. 第{i+1}位字符为[a-z]")
        print("4. 第{i+1}位字符为[a-z]+[A-Z]+[0-9]")
        char_choice = get_input("请输入你的选择（1，2，3或4）：", "输入无效，请输入1，2，3或4", lambda x: x in ['1', '2', '3', '4'])
        if char_choice == '1':
            chars.append(string.ascii_lowercase + string.digits)
        elif char_choice == '2':
            chars.append(string.digits)
        elif char_choice == '3':
            chars.append(string.ascii_lowercase)
        elif char_choice == '4':
            chars.append(string.ascii_letters + string.digits)
        print(f"第{i+1}位字符的构成是：{char_choices[int(char_choice)-1]}")
    while True:
        modify = input("你是否需要修改字符的构成？（y/n）：")
        if modify.lower() == 'y':
            chars = []
            for i in range(start):
                print(f"请输入第{i+1}位字符的构成：")
                print("1. 第{i+1}位字符为[a-z]+[0-9]")
                print("2. 第{i+1}位字符为[0-9]")
                print("3. 第{i+1}位字符为[a-z]")
                print("4. 第{i+1}位字符为[a-z]+[A-Z]+[0-9]")
                char_choice = get_input("请输入你的选择（1，2，3或4）：", "输入无效，请输入1，2，3或4", lambda x: x in ['1', '2', '3', '4'])
                if char_choice == '1':
                    chars.append(string.ascii_lowercase + string.digits)
                elif char_choice == '2':
                    chars.append(string.digits)
                elif char_choice == '3':
                    chars.append(string.ascii_lowercase)
                elif char_choice == '4':
                    chars.append(string.ascii_letters + string.digits)
                print(f"第{i+1}位字符的构成是：{char_choices[int(char_choice)-1]}")
        elif modify.lower() == 'n':
            break
        else:
            print("输入无效，请输入y或n")
    filename_prefix = input("确认无误后，请输入文件名前缀：")

# 生成字典
for i in range(start, end+1):
    combinations = [''.join(comb) for comb in itertools.product(*chars, repeat=i)]
    filename = os.path.join(path, f'{filename_prefix}_{i}_字符.txt')
    with open(filename, 'w') as f:
        f.writelines([comb + '\n' for comb in combinations])

print("字典文件已成功创建。")
