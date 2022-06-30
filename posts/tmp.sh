for file in ./*
do
    if test -f $file
    then
        # echo $file 是文件
        echo ${file:13}
        name=${file:13}
        # time=${file:2:11}
        # sed -i "s//${name}/g" $file
        # sed -i "s/tmp.sh/${time}/g" ${file}
        mv $file $name
    fi
    if test -d $file
    then
        echo $file 是目录
    fi
done