github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
status=$(curl -s --head -w %{http_code} https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest/restic-$github_version -o /dev/null)

addr="ftp://oplab9.parqtec.unicamp.br"
path="test/marcelo/restic/latest/"

if [  $status == 404 ] 
then
    echo "GET LATEST REPO"
    git clone https://github.com/restic/restic/
    cd restic
    git checkout tags/v$github_version
    
    echo "BUILD AND TEST"
    go run build.go -T
    
    echo "MOVE OLD FROM LATEST"
    lftp -c "open -u $USER,$PASS $addr; cd $path; mv restic-$ftp_version ../"

    echo "SEND BINARY"
    mv restic restic-$github_version
    lftp -c "open -u $USER,$PASS $addr; cd $path; put restic-$github_version"
fi