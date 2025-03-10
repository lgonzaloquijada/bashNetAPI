#!/bin/bash

delete_project() {
    echo "Deleting project"
    omit_files=("generator.sh" "sh_functions" ".git")

    #delete all files and folders except the ones in the omit_files array
    shopt -s dotglob
    for file in *; do
        if [[ ! " ${omit_files[@]} " =~ " $file " ]]; then
            if [ -d "$file" ]; then
                rm -rf "$file"
            else
                rm "$file"
            fi
        fi
    done
    shopt -u dotglob
    echo "Project deleted"
}

create_project() {
    mkdir "src"
    cd "src"

    local $PROJECT_NAME="$1"
    # Create a .NET minimal API project
    echo "Creating a new .NET minimal API project called $PROJECT_NAME"
    dotnet new webapi -n $PROJECT_NAME

    # Create a test project
    echo "Creating a new test project called $PROJECT_NAME.Tests"
    dotnet new xunit -n $PROJECT_NAME.Tests

    # Add a reference to the test project
    echo "Adding a reference to the test project"
    dotnet add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj reference $PROJECT_NAME/$PROJECT_NAME.csproj

    # Add a solution file
    echo "Creating a solution file"
    dotnet new sln -n $PROJECT_NAME

    # Add the projects to the solution
    echo "Adding the projects to the solution"
    dotnet sln $PROJECT_NAME.sln add $PROJECT_NAME/$PROJECT_NAME.csproj
    dotnet sln $PROJECT_NAME.sln add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj

    # Add package references
    echo "Adding package references"
    dotnet add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj package Microsoft.AspNetCore.Mvc.Testing
    dotnet add $PROJECT_NAME.Tests/$PROJECT_NAME.Tests.csproj package MiniValidation

    # Add a Dockerfile
    cd $PROJECT_NAME
    echo "Creating a Dockerfile"
    cat <<EOL > Dockerfile 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet build -c Release -o out 

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app 
COPY --from=build /app/out . 
EXPOSE 80 
ENTRYPOINT ["dotnet", "$PROJECT_NAME.dll"]
EOL
    cd ..

    # Add a .gitignore file
    echo "Creating a .gitignore file"
    cat <<EOL > .gitignore
bin/
obj/
.vscode/
.vs/
EOL

    echo "Done"
}