
# Development Setup with Docker and PowerShell

This repository contains configuration files and Docker setup for managing your development environment across multiple Windows devices.

## Directory Structure

Here's a sample structure of the repository:

```
.
├── aliases.ps1
├── Dockerfile                       # Dockerfile for your Python setup
├── requirements.txt                 # Python dependencies
├── docker-compose.yml               # Docker Compose file for multiple services
├── Microsoft.PowerShell_profile.ps1
├── Procfile
└── README.md
```

## 1. PowerShell Profile (Microsoft.PowerShell_profile.ps1)

This file will store configurations that are automatically loaded when you open PowerShell. You can include your custom aliases, commands, and any environment settings.

### Sample content for your PowerShell profile:

```powershell
# Custom Git aliases
Set-Alias -Name gti -Value git
Set-Alias -Name gs -Value git status
Set-Alias -Name ga -Value git add
Set-Alias -Name gc -Value git commit
Set-Alias -Name gp -Value git push

# Oh My Posh initialization with Pure theme
oh-my-posh init pwsh --config "C:\Users\dylan\oh-my-posh-themes\pure.omp.json" | Invoke-Expression
```

## 2. Docker Setup

### Dockerfile
This **Dockerfile** sets up a Python environment inside a container.

```Dockerfile
# Use the official Python image from Docker Hub
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the requirements.txt file (if you have one)
COPY requirements.txt ./

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

# Set environment variables (optional)
ENV PYTHONUNBUFFERED=1

# Run a command (this can be a Python script or any entry point)
CMD ["python", "./your_script.py"]
```

### requirements.txt
List all the Python dependencies in this file:
```
flask
requests
gunicorn
```

### Building and Running the Docker Container

1. **Build the Docker Image**:
   ```bash
   docker build -t my-python-app .
   ```

2. **Run the Container**:
   ```bash
   docker run -it --rm my-python-app
   ```

### 3. Docker Compose (Optional)
You can also use **Docker Compose** to handle multiple services like Python, PostgreSQL, and Redis.

Example `docker-compose.yml` file:

```yaml
version: '3'

services:
  app:
    build: .
    container_name: python_app
    volumes:
      - .:/usr/src/app
    ports:
      - "5000:5000"
    depends_on:
      - db
    environment:
      - PYTHONUNBUFFERED=1
    command: python your_script.py

  db:
    image: postgres:latest
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

To start the services using Docker Compose:
```bash
docker-compose up
```

## 4. VS Code Settings

To keep your VS Code consistent across devices, you can include:
- `vscode/settings.json`: VS Code settings file.
- `vscode/extensions.txt`: List of extensions installed.

Generate the list of installed extensions using:
```bash
code --list-extensions > extensions.txt
```

## 5. Setting up Environment Variables (env-setup.ps1)
Use this file to configure environment variables like Python or Node.js paths:

```powershell
# Set up Python virtual environment path
$env:PYTHONPATH = "C:\path\to\your\python\env"

# Set up Node.js project path
$env:NODE_PATH = "C:\path\to\your\node\project"
```

## 6. Automation Scripts (setup.ps1)
A setup script to install dependencies or configure your environment when cloning the repository:

```powershell
# Install packages, dependencies, or tools
winget install JanDeDobbeleer.OhMyPosh
winget install Git.Git

# Set up environment variables, tools, etc.
```

## 7. README.md

Make sure to document your setup so that it’s easy to set up across devices or share with others.

```
## Setup

1. Build the Docker container:
   ```bash
   docker build -t my-python-app .
   ```

2. Run the container:
   ```bash
   docker run -it --rm my-python-app
   ```

Or with Docker Compose:

1. Start the entire stack:
   ```bash
   docker-compose up
   ```

2. Stop it:
   ```bash
   docker-compose down
   ```
```

With this setup, you can easily manage your development environment across multiple devices using Docker and PowerShell. Happy coding!
