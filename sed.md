
替换 多个空格为一个
sed -i 's/[ ][ ]*/ /g'  file.txt



每两行 替换成一行
sed 's/##//' abc.txt |sed '{N;s/\n//}' > single.txt 


抽取
cat single.txt | awk -F' ' '{print $2 , $3, $4, $11}'

