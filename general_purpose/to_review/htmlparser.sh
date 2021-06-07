TICKET_URL=https://jira.uniscon-rnd.de/browse/BAC-154

HTML=$(wget $TICKET_URL -q -O -)

#echo $HTML


#Get the sprint number...
#echo "cat //html/body/div"  | xmllint --html --shell $html
echo $HTML | grep 'Sprint'
#SPRINT_NUM=`echo $html |grep 'Sprint'|grep -o '[0-9]*' `
#echo $SPRINT_NUM


