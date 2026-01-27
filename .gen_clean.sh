#!/usr/bin/env bash
set -euo pipefail

GREEN='\033[1;32m'

directory="$(pwd)"
libDir="/lib"
dataDir="${libDir}/data/"
domainDir="${libDir}/domain/"

featureName="${1:-}"

if [[ -z "${featureName}" ]]; then
  echo "Usage: .gen_clean.sh <feature_name>"
  exit 1
fi

featureDataDir="${directory}${dataDir}${featureName}"
featureDomainDir="${directory}${domainDir}${featureName}"

apiFileName="${featureName}_api.dart"
repositoryImpFileName="${featureName}_repository_impl.dart"
repositoryFileName="${featureName}_repository.dart"
useCaseFileName="${featureName}_usecase.dart"

function writeDataFolder() {
  mkdir -p -- "${featureDataDir}"
  createApiFolder
  createModelsFolder
  createRepoImpFolder
  echo "Data folder created"
}

function writeDomainFolder() {
  mkdir -p -- "${featureDomainDir}"
  createEntitiesFolder
  createRepoFolder
  createUseCasesFolder

  echo "Domain folder created"
}

function createEntitiesFolder() {
  mkdir -p -- "${featureDomainDir}/entities"
  echo "${featureName} entities folder created"
}

function createRepoFolder() {
  mkdir -p -- "${featureDomainDir}/repositories"
  writeRepoTempFile
  echo "${featureName} repositories folder created"
}

function writeRepoTempFile() {
  cat >"${featureDomainDir}/repositories/${repositoryFileName}" <<EOF
abstract class ${featureNameCapitalize}Repository {
}
EOF
}

function createUseCasesFolder() {
  mkdir -p -- "${featureDomainDir}/usecases"
  writeUseCaseTempFile
  echo "${featureName} usecases folder created"
}

function writeUseCaseTempFile() {
  cat >"${featureDomainDir}/usecases/${useCaseFileName}" <<EOF
import '../repositories/${featureName}_repository.dart';

class ${featureNameCapitalize}UseCase {
  final ${featureNameCapitalize}Repository _repository;

  ${featureNameCapitalize}UseCase(this._repository);
}
EOF
}

function createApiFolder() {
  mkdir -p -- "${featureDataDir}/api"
  writeApiTempFile
  echo "${featureName} api folder created"
}

function writeApiTempFile() {
  cat >"${featureDataDir}/api/${apiFileName}" <<EOF
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part '${featureName}_api.g.dart';

@RestApi()
abstract class ${featureNameCapitalize}Api {
  factory ${featureNameCapitalize}Api(Dio dio, {String baseUrl}) = _${featureNameCapitalize}Api;
}
EOF
}

function createModelsFolder() {
  local modelsDir="${featureDataDir}/models"
  mkdir -p -- "${modelsDir}"
  mkdir -p -- "${modelsDir}/request"
  mkdir -p -- "${modelsDir}/response"
  echo "${featureName} models folder created"
}

function createRepoImpFolder() {
  mkdir -p -- "${featureDataDir}/repositories"
  writeRepoImpTempFile
  echo "${featureName} repoImp folder created"
}

function writeRepoImpTempFile() {
  cat >"${featureDataDir}/repositories/${repositoryImpFileName}" <<EOF
import '../api/${featureName}_api.dart';

class ${featureNameCapitalize}RepositoryImpl implements ${featureNameCapitalize}Repository {
  final ${featureNameCapitalize}Api api;

  ${featureNameCapitalize}RepositoryImpl(this.api);
}
EOF
}

echo -e "${GREEN}========================Generate ${featureName} Start======================="

featureNameCapitalize=""
IFS='_' read -r -a arrName <<<"${featureName}"
for word in "${arrName[@]}"; do
  firstChar="${word:0:1}"
  rest="${word:1}"
  capitalizeWord="$(tr '[:lower:]' '[:upper:]' <<<"${firstChar}")${rest}"
  echo "${capitalizeWord}"
  featureNameCapitalize="${featureNameCapitalize}${capitalizeWord}"
done

echo "Main directory is ${directory}"
writeDataFolder
writeDomainFolder

echo "========================Generate ${featureName} Finish======================="


