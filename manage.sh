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

   printf "Building image \e[1;33m${IMAGE_PREFIX}$1\e[0m\n"

   docker build $2 -f ${DIR}/$1/Dockerfile -t ${IMAGE_PREFIX}$1:latest ${DIR}/$1
}

PushImage() {
    ValidateImageName $1

    printf "Pushing image \e[1;33m${IMAGE_PREFIX}$1\e[0m\n"

    docker push $2 ${IMAGE_PREFIX}$1:latest
}

TagImage() {
    ValidateImageName $1

    printf "Tagging image \e[1;33m${IMAGE_PREFIX}$1\e[0m\n"

    docker tag ${IMAGE_PREFIX}$1:latest ${IMAGE_PREFIX}$1:$2
}

case $1 in
    build)
        ValidateImageName $2

        Title "Build ${IMAGE_PREFIX}$2"
        ConfirmPrompt

        BuildImage $2 "${*:3}"
    ;;
    # ------------- PUSH -------------
    push)
        ValidateImageName $2

        Title "Push ${IMAGE_PREFIX}$2"
        ConfirmPrompt

        PushImage $2 "${*:3}"
    ;;
    # ------------- PUSH -------------
    tag)
        ValidateImageName $2

        Title "Tagging ${IMAGE_PREFIX}$2 to $3"
        ConfirmPrompt

        TagImage $2 $3
    ;;
    # ------------- HELP -------------
    *)
        Help "Usage: ./manage.sh [args]
- build [name] [options]: Builds the [name] image.
- push [name] [options]: Pushes the [name] image.
- tag [name] [tag]: Tags the [name] image.
"
    ;;
esac
