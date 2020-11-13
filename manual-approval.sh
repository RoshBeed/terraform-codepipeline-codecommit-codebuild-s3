#!/bin/env bash
pipeline=$(terraform output -json | jq -r '.codepipeline_pipeline_name.value')
token=$(aws codepipeline get-pipeline-state \
	--name $pipeline \
	--query 'stageStates[?latestExecution.status==`InProgress`].{token:actionStates[0].latestExecution.token}' | jq -r '.[].token')
aws codepipeline put-approval-result \
	--pipeline-name $pipeline \
	--stage-name Manual_Approval \
	--action-name Manual-Approval \
	--result summary=ok,status=Approved \
	--token $token
