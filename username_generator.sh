#!/bin/bash

# 检查字典目录是否存在，如果不存在则创建
if [ ! -d "字典" ]; then
    mkdir 字典
fi

# 询问用户要创建的字典的位数或位数范围
echo "你想要创建特定位数的字典还是位数范围的字典？"
echo "1. 特定位数"
echo "2. 位数范围"
read option

if [ $option -eq 1 ]; then
    echo "请输入你想要创建的字典的位数："
    read start
    end=$start
elif [ $option -eq 2 ]; then
    echo "请输入你想要创建的字典的位数范围（如：2-5）："
    read range
    start=${range%-*}
    end=${range#*-}
else
    echo "无效的选择。"
    exit 1
fi

# 提供一些快速模式
echo "请选择一个模式："
echo "1. 所有字符均为数字"
echo "2. 所有字符均为小写字母"
echo "3. 所有字符均为大写字母"
echo "4. 所有字符均为小写字母或数字"
echo "5. 所有字符均为大写字母或数字"
echo "6. 所有字符均为大小写字母或数字"
echo "7. 自定义模式"
read mode

charset=""
if [ $mode -eq 7 ]; then
    for ((i=1; i<=$end; i++)); do
        echo "第 $i 位是由什么构成？"
        echo "1. 数字"
        echo "2. 小写字母"
        echo "3. 大写字母"
        echo "4. 数字和小写字母"
        echo "5. 数字和大写字母"
        echo "6. 数字和大小写字母"
        read choice
        case $choice in
            1)
                charset+="{0..9}"
                ;;
            2)
                charset+="{a..z}"
                ;;
            3)
                charset+="{A..Z}"
                ;;
            4)
                charset+="0-9a-z"
                ;;
            5)
                charset+="0-9A-Z"
                ;;
            6)
                charset+="0-9a-zA-Z"
                ;;
            *)
                echo "无效的选择。"
                exit 1
        esac
    done
    echo "请输入你想要的文件名："
    read filename
else
    case $mode in
        1)
            charset="{0..9}"
            filename="数字"
            ;;
        2)
            charset="{a..z}"
            filename="小写字母"
            ;;
        3)
            charset="{A..Z}"
            filename="大写字母"
            ;;
        4)
            charset+="0-9a-z"
            filename="小写字母或数字"
            ;;
        5)
            charset+="0-9A-Z"
            filename="大写字母或数字"
            ;;
        6)
            charset+="0-9a-zA-Z"
            filename="大小写字母或数字"
            ;;
        *)
            echo "无效的选择。"
            exit 1
    esac
fi

for ((length=start; length<=end; length++)); do
    command="echo -n "
    for ((i=1; i<=length; i++)); do
        command+="\$(echo -n \"$charset\" | shuf -n1)"
    done
    command+=" >> 字典/${filename}_${start}-${end}位.txt"
    eval $command
done

echo "字典已经生成在 字典/${filename}_${start}-${end}位.txt 文件中。"
