#!/bin/bash

REPO_URL="https://github.com/alexeyzayac/devops-netology.git"
BRANCH="15.04_practical_docker"
TARGET_DIR="/opt/devops-netology"

git clone --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
cd "$TARGET_DIR" || exit

docker compose up -d
