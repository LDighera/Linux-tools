#!bash
for i in $(find /root/bin) ;do
  echo $i
  read -n1 -p"chmod?"
  [[ $REPLY == [y] ]] && chmod -v 755 $i
done

