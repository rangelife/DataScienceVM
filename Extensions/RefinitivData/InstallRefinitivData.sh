/anaconda/bin/pip install google-cloud-bigquery==1.4.0
/anaconda/bin/pip install elasticsearch==6.3.1

cd /home
cd *

mkdir -p notebooks
chown 1003:1003 notebooks
cd notebooks

mkdir -p Refinitiv
cd Refinitiv

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





