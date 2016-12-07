#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_PATH=${DIR}/docker_logs.txt

IMAGE_PREFIX="ekyna/"
IMAGE_REGEXP="^php7-fpm(-dev)?|nginx|mysql|elasticsearch|varnish$"

echo "" > ${LOG_PATH}

Title() {
    printf "\n\e[1;104m ----- $1 ----- \e[0m\n"
}

Help() {
    printf "\n\e[2m$1\e[0m\n";
}

ConfirmPrompt () {
    printf "\n"

    choice=""
    while [ "$choice" != "n" ] && [ "$choice" != "y" ]
    do
        printf "Do you want to continue ? (N/Y)"
        read choice
        choice=$(echo ${choice} | tr '[:upper:]' '[:lower:]')
    done

    if [ "$choice" = "n" ]; then
        echo "\nAbort by user.\n"
        exit 0
    fi

    printf "\n"
}

ValidateImageName() {
    if [[ ! $1 =~ $IMAGE_REGEXP ]]
    then
        printf "\e[31mInvalid image name\e[0m\n"
        exit 1
    fi
}

BuildImage() {
   ValidateImageName $1

   printf "Building image \e[1;33m${IMAGE_PREFIX}$1\e[0m ... "

   docker build -f ${DIR}/$1/Dockerfile -t ${IMAGE_PREFIX}$1:latest ${DIR}/$1 >> ${LOG_PATH} 2>&1 \
       && printf "\e[32mdone\e[0m\n" \
       || (printf "\e[31merror\e[0m\n" && exit 1)
}

PushImage() {
    ValidateImageName $1

    printf "Pushing image \e[1;33m${IMAGE_PREFIX}$1\e[0m ... "

    docker push ${IMAGE_PREFIX}$1:latest >> ${LOG_PATH} 2>&1 \
       && printf "\e[32mdone\e[0m\n" \
       || (printf "\e[31merror\e[0m\n" && exit 1)
}

case $1 in
    build)
        ValidateImageName $2

        Title "Build ${IMAGE_PREFIX}$2"
        ConfirmPrompt

        BuildImage $2
    ;;
    # ------------- PUSH -------------
    push)
        ValidateImageName $2

        Title "Push ${IMAGE_PREFIX}$2"
        ConfirmPrompt

        PushImage $2
    ;;
    # ------------- HELP -------------
    *)
        Help "Usage: ./manage.sh [args]
- build [name] : Build the [name] image.
- push [name] : Push the [name] image.
"
    ;;
esac
