#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_PATH=${DIR}/docker_logs.txt

IMAGE_PREFIX="ekyna/"
IMAGE_REGEXP="^php7-fpm(-dev)?|nginx|mysql|elasticsearch|varnish$"
TAG_REGEXP="^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$"

echo "" > ${LOG_PATH}

Title() {
    printf "\n\e[1;104m ----- %s ----- \e[0m\n" "${1}"
}

Help() {
    printf "\n\e[2m%s\e[0m\n" "${1}";
}

ConfirmPrompt () {
    printf "\n"

    choice=""
    while [ "$choice" != "n" ] && [ "$choice" != "y" ]
    do
        printf "Do you want to continue ? (N/Y)"
        read -r choice
        choice=$(echo "${choice}" | tr '[:upper:]' '[:lower:]')
    done

    if [ "$choice" = "n" ]; then
        printf "\nAbort by user.\n"
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

ValidateTagName() {
    if [[ ! $1 =~ $TAG_REGEXP ]]
    then
        printf "\e[31mInvalid tag name\e[0m\n"
        exit 1
    fi
}

BuildImage() {
   ValidateImageName "${1}"

   printf "Building image \e[1;33m%s\e[0m\n" "${IMAGE_PREFIX}${1}"

   docker build ${2} -f "${DIR}/$1/Dockerfile" -t "${IMAGE_PREFIX}${1}:latest" "${DIR}/${1}"
}

PushImage() {
    ValidateImageName "${1}"
    ValidateTagName "${2}"

    printf "Pushing image \e[1;33m%s\e[0m\n" "${IMAGE_PREFIX}${1}:${2}"

    docker push "${IMAGE_PREFIX}${1}:${2}"
}

TagImage() {
    ValidateImageName "${1}"
    ValidateTagName "${2}"

    printf "Tagging image \e[1;33m%s\e[0m\n" "${IMAGE_PREFIX}${1}"

    docker tag "${IMAGE_PREFIX}${1}:latest" "${IMAGE_PREFIX}${1}:${2}"
}

case $1 in
    build)
        ValidateImageName "${2}"

        Title "Build ${IMAGE_PREFIX}${2}"
        ConfirmPrompt

        BuildImage "${2}" "${*:3}"
    ;;
    # ------------- PUSH -------------
    push)
        ValidateImageName "${2}"

        TAG=latest
        if [[ "${3}" != "" ]]
        then
            ValidateTagName "${3}"
            TAG="${3}"
        fi

        Title "Push ${IMAGE_PREFIX}$2:${TAG}"
        ConfirmPrompt

        PushImage "${2}" "${TAG}"
    ;;
    # ------------- PUSH -------------
    tag)
        ValidateImageName "${2}"

        Title "Tagging ${IMAGE_PREFIX}${2} to ${3}"
        ConfirmPrompt

        TagImage "${2}" "${3}"
    ;;
    # ------------- HELP -------------
    *)
        Help "Usage: ./manage.sh [args]
- build [name] [options]  Builds the [name] image.
- push [name] [options]   Pushes the [name] image.
- tag [name] [tag]        Tags the [name] image.
"
    ;;
esac
