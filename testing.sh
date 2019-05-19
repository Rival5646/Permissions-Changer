echo -e "Enter the directory that you would like to edit the permissions for:"
read changingFile

echo "$changingFile"

currentDir=$(pwd)

echo "$currentDir"

ls -l $changingFile > files_to_change.txt
cat files_to_change.txt
#fix the column access for mac
awk {'print $9'} files_to_change.txt > the_files.txt

max=$(wc -l < the_files.txt)

cd $changingFile
echo -e "____________________________\nPermissions before:\n"
ls -l
echo "____________________________"
for ((i=2; i<=$max; i++))
do

file=$(cat $currentDir/the_files.txt | head -n "${i}" | tail -n 1)
echo "Editing $file"
if [ "$file" != "Permissions-Changer" ]; then

echo -e "Would you like to edit the permissions for the file: $file\nYes(y)\nNo(n)\nExit Program(e)"
while :
do
read edit
case $edit in
	y)

while :
do
echo -e "Choose an option\n1) User\n2) Group\n3) Other:\n"
read user
case $user in 
	1)
	user="u"
	break
	;;

	2)
	user="g"
	break
	;;

	3)
	user="o"
	break
	;;

	*)
	echo -e "Please choose either 1, 2 or 3 as an option\n"
	;;
esac
done


while :
do
echo -e  "Choose to\n1) Add\n2) Remove\nthe permission:\n"
read perm
case $perm in 
	1)
	perm="+"
	break
	;;

	2)
	perm="-"
	break
	;;

	*)
	echo -e "Please choose either 1 or 2 as an option\n"
	;;
esac
done

while :
do
echo -e  "Choose\n1) Read\n2) Write\n3) Executable:\n"
read type
case $type in 
	1)
	type="r"
	break
	;;

	2)
	type="w"
	break
	;;

	3)
	type="x"
	break
	;;

	*)
	echo -e "Please choose either 1, 2 or 3 as an option\n"
	;;
esac
done

	chmod $user$perm$type $file
	echo "changed the permissions on" $file
	ls -l $file
	echo ""
	break
	;;

	n)
	echo "No changes made to $file"
	break
	;;

	e)
	break 3
	;;

	*)
	echo -e "Enter a valid option\nYes(y)\nNo(n)\nExit Program(e)"
esac
done
else
:
fi
done
echo -e "_________________________________________\nPermissions after:"
ls -l
echo "_________________________________________"
