#!/usr/bin/env sh

# github-release -> go install github.com/github-release/github-release@v0.10.0


GITHUB_TOKEN='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'

set -x

GITHUB_USER=$(git config --get user.name)
GITHUB_REPO=$(git remote get-url origin)

# Required format: X.X.X, where X is int
VERSION=$1
shift

# Version equivalent used by GitHub
GIT_TAG="v${VERSION}"

# Name of release that will be created
NAME=$1
shift

# What will constitute description of release
DESCRIPTION=$1
shift

# Sequence of 
GLOBS="$@"

set +x


echo 'Parse version'
echo "$VERSION" \
    | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' \
    || { echo "Version parse failed: ${VERSION}";  exit 1; }


echo 'Ensure clean git stage'
[[ -z $(git status --porcelain) ]] \
    || { echo 'Git stage was not clean'; exit 2; }


echo 'Ensure tag does not exist already'
[[ -z $(git tag -l "$GIT_TAG") ]] \
    || { echo "Tag already existed: ${GIT_TAG}"; exit 3; }


echo 'Set the version and create the commit'
poetry version "$VERSION" \
    && git add . \
    && git commit -m "Bump version to ${GIT_TAG}" \
    && git tag "$GIT_TAG" \
    || { echo 'Could not bump version locally'; exit 4; }


echo 'Update origin with new tag'
git push \
    && git push --tags \
    || { echo 'Failed to update origin'; exit 5; }


echo 'Create release'
github-release info $GIT_TAG \
    || github-release release \
        --tag  "$GIT_TAG" \
        --name "$NAME" \
        --description "$DESCRIPTION" \
    || { echo 'Failed to create release'; exit 6; }


echo 'Upload files'
for glob in $GLOBS; do
    for file in$(find $glob); do
        echo "Upload: ${file}"
        github-release upload
            --tag "$GIT_TAG" \
            --name "$(basename $file)" \
            --file "$file"
        || echo "Failed to upload: ${file}"
    done
done