#!/bin/sh

cd `dirname "${BASH_SOURCE[0]}"`
if [ ! -d "~/Library/Application Support/V2RayC/" ];then
    sudo mkdir -p "~/Library/Application Support/V2RayC/"
else
    echo "文件夹已经存在"
fi

echo done
