echo " - Download CHELSA monthly timeseries"

URLS="$1"
OUTDIR="$2"
if [ -d $OUTDIR ]
then
  cd $OUTDIR
else
  exit 1
fi

# create array
mapfile -t chelsa < "$URLS"

# download files that were not already downloaded
echo " - Downloading present climate"
for x in "${chelsa[@]}"
do
  z=$(echo "$x" | cut -d "/" -f 10) #drops the url except file name
  if [ ! -f $z ]
  then
    echo "     Downloading $z"
    wget -q $x || exit 1
  else echo " $z already downloaded"
  fi
done

echo " - Download finished"
echo " - END"

