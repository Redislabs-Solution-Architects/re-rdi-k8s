case $1 in
    aws|azure|gcp|kind)
        $PWD/$1/destroy.sh
        ;;
    *)
        echo "Usage: stop.sh <k8s env: aws|azure|gcp|kind" 1>&2
        exit 1
        ;;
esac