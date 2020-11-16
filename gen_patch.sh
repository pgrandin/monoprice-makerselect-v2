cd Marlin
git diff -u  > ../sbase.patch
git checkout .
cd ..
sed -i -e 's@-- a/@-- @g' sbase.patch
sed -i -e 's@++ b/@++ @g' sbase.patch
