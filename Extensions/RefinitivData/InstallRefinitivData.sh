/anaconda/bin/pip install google-cloud-bigquery==1.4.0
/anaconda/bin/pip install elasticsearch==6.3.1

cd /home
cd *

mkdir -p notebooks
chown 1003:1003 notebooks
cd notebooks

mkdir -p Refinitiv
cd Refinitiv


export DSA_PERMID=1-5064690523
export DSA_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhcHAtZGF0YXNjaWVuY2VhY2NlbGVyYXRvci1mcl9ub25wcm9kX2Rldi1pcmVsYW5kLWRldiIsImV4cCI6MTU0NDgwMDM2MCwianRpIjoiNDU0NzAyZTctZWEwNC00YzMwLTkzZjktMzYzZjQ5N2RjNjlkIiwiaWF0IjoxNTQ0NzEzOTYwLCJpc3MiOiJhcHAtZGF0YXNjaWVuY2VhY2NlbGVyYXRvci1mcl9ub25wcm9kX2Rldi1pcmVsYW5kLWRldiIsIm5iZiI6MTU0NDcxMzk2MCwic3ViIjoiZTk2ZjFiZTctYjAyMC01NzI1LWI1NGYtYWJjMTNhNzU0MzU1IiwiZHN0IjoiYXBwLWRhdGFzY2llbmNlYWNjZWxlcmF0b3ItZnJfbm9ucHJvZF9kZXYtaXJlbGFuZC1kZXYiLCJzdWJfZW1haWwiOiJyb2IubHVuZGllaGlsbEB0aG9tc29ucmV1dGVycy5jb20iLCJzdWJfbmFtZSI6IlJvYmVydCBKb2huIEx1bmRpZSBIaWxsIiwic3ViX3Byb3ZpZGVyLW5hbWUiOiJ0cmlkIiwic3ViX3Byb3ZpZGVyLWlkIjoiOTAwNjNjNDAtYjc4NS00NDAxLWFjNjYtYjZlMTAxYmE4ODQ5In0.uMiX92SQId5KzyDtRb-aNErs5YSjBzwKDTno7fe3yY8
export DSA_ENV=dev


curl -v -O 'https://dsa-'$DSA_ENV'-ecs-api.fr-nonprod.aws.thomsonreuters.com/v1/examples/'$DSA_PERMID'/data-science-accelerator-examples.zip' \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'Referer: https://data-science-accelerator-'$DSA_ENV'.fr-nonprod.aws.thomsonreuters.com/notebooks(modal:download-notebooks)' \
    -H 'Origin: https://data-science-accelerator-'$DSA_ENV'.fr-nonprod.aws.thomsonreuters.com' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36' \
    -H 'Authorization: Bearer '$DSA_TOKEN \
    --compressed \
    -w '%{http_code}' \
    > status_code

if [ "$(cat status_code)" != "200" ]; then
    echo "REQUEST FAILED, STATUS CODE "$(cat status_code)
    cat data-science-accelerator-examples.zip
    exit 1
fi

unzip data-science-accelerator-examples.zip

mv data-science-accelerator-examples/notebooks/* .

rm -rf data-science-accelerator-examples.zip data-science-accelerator-examples 

cd ..
chown -R 1003:1003 Refinitiv





