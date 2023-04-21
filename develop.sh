#!/usr/bin/env bash

PROJECT_NAME="dmarc"
COMMAND_NAME="${0##*/}"

function usage {
    cat << USAGE >&2

${COMMAND_NAME} <command> [params]

Daily usage:
    up:         start the containers
    stop:       stop the containers
    down:       stop and destroy the containers

    compose:    access docker compose with current configuration
USAGE
}

[ -z "${1}" ] && usage && exit 0

function docker_compose {
    docker-compose --project-name "${PROJECT_NAME}" \
        -f docker-compose.yml $@
}

case "${1}" in
    compose )
        shift 1
        docker_compose "$@"
        ;;
    up )
        shift 1
        docker_compose up -d "$@"
        ;;
    stop )
        shift 1
        docker_compose stop "$@"
        ;;
    ps )
        shift 1
        docker_compose ps "$@"
        ;;
    logs|log )
        shift 1
        docker_compose logs "$@"
        ;;
    down )
        docker_compose stop
        docker_compose down \
        --rmi local \
        --volumes \
        --remove-orphans
    ;;
    * )
      echo "Unknown command"
      usage
      exit 1
esac

