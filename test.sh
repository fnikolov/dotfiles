#!/usr/bin/env sh
set -x
# Pre-receive hook that will block commits with messges that do not follow regex rule

commit_msg_type_regex='feat|fix|refactor|style|test|docs|build'
commit_msg_scope_regex='.{1,20}'
commit_msg_subject_regex='.{1,100}'
commit_msg_regex="^(${commit_msg_type_regex})(\(${commit_msg_scope_regex}\))?: (${commit_msg_subject_regex})\$"
#merge_msg_regex="^Merge branch '.+'\$"
#revert_msg_regex="^Revert \".+\"\$"
#
#zero_commit="0000000000000000000000000000000000000000"
#
## Do not traverse over commits that are already in the repository
#excludeExisting="--not --all"
#
#error=""
#while read oldrev newrev refname; do
#  # branch or tag get deleted
#  if [ "$newrev" = "$zero_commit" ]; then
#    continue
#  fi
#
#  # Check for new branch or tag
#  if [ "$oldrev" = "$zero_commit" ]; then
#    rev_span=`git rev-list $newrev $excludeExisting`
#  else
#
    #commit_msg_header=fea
    if [[ "ffgx" =~ (${commit_msg_regex}) ]]; then
      #echo "$commit this is commit"
      echo "ERROR: Invalid commit message format"
      #echo "$commit_msg_header"
      #error="true"
    fi
#done
#
#if [ -n "$error" ]; then
#  exit 1
#fi
