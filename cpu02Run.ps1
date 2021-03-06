﻿param([string]$QuestionArgs="c:\dockerExchange\input.csv output.csv") 

$env:Path="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\amd64\;C:\Program Files\Docker\Docker\resources\bin\"

# Docker image name for the application
$ImageName="profesor79_pl_actor_scaling_example"

function Invoke-Docker-Run ([string]$DockerImage, [string]$Question) {
	echo "starting with files: $Question, cpus=2.0"
	
	Invoke-Expression "docker run  --cpus=`"2.0`"  -v c:/dockerExchange:c:/dockerExchange --rm $ImageName $Question"
	
}

Invoke-Docker-Run  $QuestionArgs  -DockerImage $ImageName
