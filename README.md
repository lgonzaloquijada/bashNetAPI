# TestAPI Project

This project is a Bash script (`generator.sh`) that can create or delete the project. The .NET API solution includes a main API project and a test project. 

## Project Structure

```
.gitignore
generator.sh
sh_functions/
    net_solution.sh
    utils.sh
src/
    # This folder is where the bash script generates a new project code
```

## Main Functionality

### `generator.sh`

The `generator.sh` script is used to manage the project. It supports the following operations:

- `--create <ProjectName>`: Creates a new project with the specified name.
- `--delete <ProjectName>`: Deletes the specified project.

#### Usage

```bash
./generator.sh --create --name <ProjectName>
./generator.sh --delete
```

### `sh_functions/`

This directory contains helper scripts used by `generator.sh`:

- `net_solution.sh`: Contains functions related to .NET solution management.
- `utils.sh`: Contains utility functions.

## Getting Started

1. Clone the repository.
2. Run the `generator.sh` script to create or delete projects as needed.
3. Open the solution in your preferred IDE (e.g., Visual Studio or Visual Studio Code).
4. Build and run the projects.

## License

This project is licensed under the MIT License.