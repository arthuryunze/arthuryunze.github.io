for file in ./*
do
    if test -f $file
    then
        # echo $file 是文件
        echo ${file:2:10}
        # name=${file:13:-3}
        time=${file:2:10}
        # sed -i "s//${name}/g" $file
        sed -i "s/tmp.sh/${time}/g" ${file}
    fi
    if test -d $file
    then
        echo $file 是目录
    fi
done