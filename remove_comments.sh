#!/bin/bash

# Navigate to your Flutter project directory
cd /d/working/flutter-banking-app

# Base branch name
base_branch="feature/web3auth"

for i in {1..40}
do
    # Checkout the base branch and pull latest changes
    git checkout $base_branch
    git pull origin $base_branch

    # Create a new branch
    new_branch="remove-comments-$i"
    git checkout -b $new_branch

    # Find all Dart files and remove single-line comments
    find . -name '*.dart' -exec sed -i 's|//.*||g' {} +

    # Remove multi-line comments
    find . -name '*.dart' -exec sed -i '/\/\*/,/\*\//d' {} +

    # Add changes to git and commit them
    git add .
    git commit -m "Remove comments from Dart files"

    # Push the new branch to remote
    git push origin $new_branch

    # Create a pull request
    gh pr create --base $base_branch --head $new_branch --title "Remove Comments PR $i" --body "Automated PR to remove comments from Dart files"

done