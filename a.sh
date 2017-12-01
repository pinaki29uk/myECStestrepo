#!/bin/bash 

 
 cluster=mycluster
 container_instance=c00654f6-ce4c-4317-86ef-e03affa18659
 tasks=$(aws --region us-east-1 ecs list-tasks --container-instance $container_instance --cluster $cluster | jq -r '.taskArns | map(.[40:]) | reduce .[] as $item (""; . + $item + " ")') 
 for task in $tasks; do 
echo $task
 	aws --region us-east-1 ecs stop-task --task $task --cluster $cluster 
        aws --region us-east-1 ecs start-task --task $task --cluster $cluster --container-instances $container_instance
 done 

