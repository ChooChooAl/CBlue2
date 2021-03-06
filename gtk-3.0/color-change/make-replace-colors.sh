#!/bin/bash
rm alk 2>/dev/null
rm alk2 2>/dev/null

for a in *.css */*.css
do
echo -n $a"    "
    grep -i "#[0-9|A-Z][0-9|A-Z][0-9|A-Z][0-9|A-Z][0-9|A-Z][0-9|A-Z];" $a | sort | uniq >> alk
done
echo
for a in *.css */*.css
do
echo -n $a"    "
    grep -i "rgba(" $a  >> alk2
done
echo

cat alk2 |sort|uniq > alk3

echo "#!/bin/bash
" > replace-colors.sh
for a in `cat alk | grep "#"`
do
R=`echo $a | cut -c2-3`
G=`echo $a | cut -c4-5`
B=`echo $a | cut -c6-7`
echo $a "  " $R" "$G" "$B
echo sed -i \'s\/#$R$G$B"/#"$B$G$R"/g' \$1" >>replace-colors-1.sh
done

echo "#!/bin/bash
" > replace-colors-2.sh

paste -d "/" alk3 alk3 > replace-2.sh
rm alk2 alk alk3

sleep 10
