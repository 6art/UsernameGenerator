#!/bin/bash

# 询问用户要创建的字典的位数
echo "请输入你想要创建的字典的位数："
echo "1. 特定位数"
echo "2. 位数范围"
read type

if [ $type -eq 1 ]
then
    echo "请输入你想要创建的字典的位数："
    read length
    min_length=$length
    max_length=$length
elif [ $type -eq 2 ]
then
    echo "请输入你想要创建的字典的最小位数："
    read min_length
    echo "请输入你想要创建的字典的最大位数："
    read max_length
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

charset_array=()
for ((i=1; i<=$max_length; i++))
do
    if [ $mode -eq 7 ]
    then
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
                charset_array+=("{0..9}")
                ;;
            2)
                charset_array+=("{a..z}")
                ;;
            3)
                charset_array+=("{A..Z}")
                ;;
            4)
                charset_array+=("{{0..9},{a..z}}")
                ;;
            5)
                charset_array+=("{{0..9},{A..Z}}")
                ;;
            6)
                charset_array+=("{{0..9},{a..z},{A..Z}}")
                ;;
            *)
                echo "无效的选择。"
                exit 1
        esac
    else
        case $mode in
            1)
                charset_array+=("{0..9}")
                ;;
            2)
                charset_array+=("{a..z}")
                ;;
            3)
                charset_array+=("{A..Z}")
                ;;
            4)
                charset_array+=("{{0..9},{a..z}}")
                ;;
            5)
                charset_array+=("{{0..9},{A..Z}}")
                ;;
            6)
                charset_array+=("{{0..9},{a..z},{A..Z}}")
                ;;
            *)
                echo "无效的选择。"
                exit 1
        esac
    fi
done

echo "请输入你想要的文件名："
read filename

mkdir -p 字典
for ((n=$min_length; n<=$max_length; n++))
do
    command="echo "
    for ((i=0; i<$n; i++))
    do
        command+="${charset_array[$i]}"
    done
    command+=" | sed 's/ /\n/g' > 字典/${filename}_${n}位.txt"
    eval $command
    echo "字典已经生成在 字典/${filename}_${n}位.txt 文件中。"
done
