ls -l > files_to_change.txt

awk {'print $9'} files_to_change.txt > the_files.txt

for i in 2 3 4 5
do

file=$(cat the_files.txt | head -n "${i}" | tail -n 1)
echo $file
chmod u-x $file
done
