﻿<#
.SYNOPSIS
   Build the Console Application and Docker Image for Windows container
.DESCRIPTION
    Build the Console Application and Docker Image for Windows container
#>

Set-StrictMode -Version Latest
$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"

# Docker image name for the application
$ImageName="profesor79pl/profesor79_pl_actor_scaling_example_target"

function Invoke-MSBuild ([string]$MSBuildPath, [string]$MSBuildParameters) {
    Invoke-Expression "$MSBuildPath $MSBuildParameters"
}

function Invoke-Docker-Build ([string]$ImageName, [string]$ImagePath, [string]$DockerBuildArgs = "") {
    echo "docker build -t $ImageName $ImagePath $DockerBuildArgs"
    Invoke-Expression "docker build -t $ImageName $ImagePath $DockerBuildArgs"
}

$env:Path="C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\amd64\;C:\Program Files\Docker\Docker\resources\bin\"

$msbuil="MSBuild.exe"
Invoke-MSBuild -MSBuildPath $msbuil -MSBuildParameters ".\Profesor79.Merge.RemoteDeployTarget\Profesor79.Merge.RemoteDeployTarget.csproj /p:OutputPath=.\publishRemoteDeployTarget /p:Configuration=Release"
Invoke-Docker-Build -ImageName $ImageName -ImagePath ".\Profesor79.Merge.RemoteDeployTarget\."
